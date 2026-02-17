import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet/src/client/transaction_client.dart';
import 'package:wallet/src/modules/home/model/transaction_item.dart';
import 'package:wallet/src/providers/auth_provider.dart';
import 'package:wallet/src/providers/base_provider.dart';
import 'package:wallet/src/reusables/models/responses/journal.dart';
import 'package:wallet/src/reusables/utils/show_loading.dart';
import 'package:wallet/src/reusables/utils/storage_util.dart';

final transactionProvider = ChangeNotifierProvider(
  (ref) => TransactionProvider(ref),
);

class TransactionProvider extends BaseProvider {
  final Ref _ref;

  TransactionProvider(this._ref)
    : super(autoLoad: true, enableDebugLogs: true) {
    _filteredTransactions = _allTransactions;
    _searchController.addListener(_filterTransactions);
  }

  static const String _transactionsKey = 'transactions_data';

  final TransactionClient _client = TransactionClient();

  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  bool _isExpanded = false;
  bool get isExpanded => _isExpanded;
  set isExpanded(bool value) {
    _isExpanded = value;
    notifyListeners();
  }

  List<TransactionItem> _allTransactions = [];
  List<TransactionItem> get allTransactions => _allTransactions;
  set allTransactions(List<TransactionItem> value) {
    _allTransactions = value;
    _saveTransactionsToStorage();
    notifyListeners();
  }

  List<TransactionItem> _filteredTransactions = [];
  List<TransactionItem> get filteredTransactions => _filteredTransactions;
  set filteredTransactions(List<TransactionItem> value) {
    _filteredTransactions = value;
    notifyListeners();
  }

  void _filterTransactions() {
    final query = _searchController.text.toLowerCase();
    if (query.isEmpty) {
      _filteredTransactions = _allTransactions;
    } else {
      _filteredTransactions = _allTransactions.where((transaction) {
        return transaction.name.toLowerCase().contains(query) ||
            transaction.date.toLowerCase().contains(query) ||
            transaction.amount.contains(query);
      }).toList();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Future<void> loadInitialData() async {
    await _loadTransactionsFromStorage();
  }

  Future<void> _loadTransactionsFromStorage() async {
    try {
      final transactionsJson = await StorageUtil.instance.get<String>(
        _transactionsKey,
      );

      if (transactionsJson != null) {
        final List<dynamic> decodedList = jsonDecode(transactionsJson);
        _allTransactions = decodedList
            .map((json) => TransactionItem.fromJson(json))
            .toList();
        _filteredTransactions = _allTransactions;

        debugPrint(
          '[TransactionProvider] Loaded ${_allTransactions.length} transactions from storage',
        );
      } else {
        debugPrint('[TransactionProvider] No transactions found in storage');
      }
    } catch (e) {
      debugPrint('[TransactionProvider] Error loading transactions: $e');
      _allTransactions = [];
      _filteredTransactions = [];
    }
    notifyListeners();
  }

  Future<void> _saveTransactionsToStorage() async {
    try {
      final transactionsJson = jsonEncode(
        _allTransactions.map((t) => t.toJson()).toList(),
      );
      await StorageUtil.instance.save(_transactionsKey, transactionsJson);
      debugPrint(
        '[TransactionProvider] Saved ${_allTransactions.length} transactions to storage',
      );
      // _allTransactions.forEach(
      //   (each) => log(each.amount, name: "amount ${each.name}"),
      // );
    } catch (e) {
      debugPrint('[TransactionProvider] Error saving transactions: $e');
    }
  }

  void _addTransaction(TransactionItem transaction) {
    _allTransactions.insert(0, transaction);
    _filteredTransactions = _allTransactions;
    _saveTransactionsToStorage();
    notifyListeners();
  }

  Future<void> credit(int amount) async {
    showLoading();

    await handleApiCall(
      apiCall: () => _client.credit(amount: amount, fromJson: Journal.fromJson),
      onSuccess: (response) async {
        await _updateUserBalanceFromResponse(response);

        final transaction = _createTransactionFromJournal(
          response,
          isCredit: true,
          amount: amount,
        );
        _addTransaction(transaction);
      },
      customErrorMessage: "Failed to credit user",
    );

    cancelLoading();
  }

  Future<void> debit(int amount) async {
    showLoading();

    await handleApiCall(
      apiCall: () => _client.debit(amount: amount, fromJson: Journal.fromJson),
      onSuccess: (response) async {
        await _updateUserBalanceFromResponse(response);

        final transaction = _createTransactionFromJournal(
          response,
          isCredit: false,
          amount: amount,
        );
        _addTransaction(transaction);
      },
      customErrorMessage: "Failed to debit user",
    );

    cancelLoading();
  }

  TransactionItem _createTransactionFromJournal(
    Journal response, {
    required bool isCredit,
    required int amount,
  }) {
    final amountInDecimal = amount.toStringAsFixed(2);
    final now = DateTime.now();
    final dateString = '${_monthName(now.month)} ${now.day}, ${now.year}';

    return TransactionItem(
      name: isCredit ? 'Money Received' : 'Money Sent',
      date: dateString,
      icon: isCredit
          ? Icons.arrow_downward_rounded
          : Icons.arrow_upward_rounded,
      amount: amountInDecimal,
      isCredit: isCredit,
    );
  }

  String _monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  Future<void> _updateUserBalanceFromResponse(Journal response) async {
    try {
      final authProv = _ref.read(authProvider);

      final currentUser = authProv.user;

      if (currentUser == null || currentUser.account == null) {
        debugPrint(
          '[TransactionProvider] Cannot update balance - user or account is null',
        );
        return;
      }

      final newBalance = response.accountJournal?.balanceAfter;

      if (newBalance == null) {
        debugPrint(
          '[TransactionProvider] No balance found in response, refreshing from server',
        );
        await refreshBalance();
        return;
      }

      final updatedAccount = currentUser.account!.copyWith(
        balance: newBalance.toString(),
      );

      final updatedUser = currentUser.copyWith(account: updatedAccount);

      authProv.user = updatedUser;

      debugPrint('[TransactionProvider] Balance updated to: $newBalance');
    } catch (e, stackTrace) {
      debugPrint('[TransactionProvider] Error updating balance: $e');
      debugPrint('[TransactionProvider] Stack trace: $stackTrace');

      await refreshBalance();
    }
  }

  Future<void> refreshBalance() async {
    try {
      debugPrint('[TransactionProvider] Refreshing balance from server');
      final authProv = _ref.read(authProvider);
      await authProv.getUserDetails();
    } catch (e) {
      debugPrint('[TransactionProvider] Error refreshing balance: $e');
    }
  }

  Future<void> clearTransactions() async {
    try {
      await StorageUtil.instance.remove(_transactionsKey);
      _allTransactions = [];
      _filteredTransactions = [];
      notifyListeners();
      debugPrint('[TransactionProvider] Cleared all transactions');
    } catch (e) {
      debugPrint('[TransactionProvider] Error clearing transactions: $e');
    }
  }
}
