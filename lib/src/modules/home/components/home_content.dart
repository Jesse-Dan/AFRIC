import 'package:flutter/material.dart';
import 'package:wallet/src/config/color_config.dart';
import 'package:wallet/src/modules/home/components/quick_actions_section.dart';
import 'package:wallet/src/modules/home/components/recent_transactions_section.dart';
import 'package:wallet/src/modules/home/components/search_field.dart';
import 'package:wallet/src/modules/home/model/transaction_item.dart';
import 'package:wallet/src/providers/theme_provider.dart';
import 'package:wallet/src/reusables/components/app_container.dart';
import 'package:wallet/src/reusables/utils/ref_holder.dart';

class HomeContentWidget extends StatefulWidget {
  const HomeContentWidget({super.key});

  @override
  State<HomeContentWidget> createState() => _HomeContentWidgetState();
}

class _HomeContentWidgetState extends State<HomeContentWidget> {
  bool _isExpanded = false;
  final TextEditingController _searchController = TextEditingController();
  List<TransactionItem> _allTransactions = [];
  List<TransactionItem> _filteredTransactions = [];

  @override
  void initState() {
    super.initState();
    _allTransactions = [
      TransactionItem(
        name: 'Salary Deposit',
        date: 'Feb 15, 2026',
        icon: Icons.account_balance_wallet_outlined,
        amount: '2,500.00',
        isCredit: true,
      ),
      TransactionItem(
        name: 'Grocery Shopping',
        date: 'Feb 14, 2026',
        icon: Icons.shopping_cart_outlined,
        amount: '45.20',
        isCredit: false,
      ),
      TransactionItem(
        name: 'Netflix Subscription',
        date: 'Feb 13, 2026',
        icon: Icons.play_circle_outline,
        amount: '15.99',
        isCredit: false,
      ),
      TransactionItem(
        name: 'Transfer to Savings',
        date: 'Feb 12, 2026',
        icon: Icons.savings_outlined,
        amount: '200.00',
        isCredit: false,
      ),
      TransactionItem(
        name: 'Refund - Amazon',
        date: 'Feb 11, 2026',
        icon: Icons.receipt_outlined,
        amount: '32.50',
        isCredit: true,
      ),
    ];
    _filteredTransactions = _allTransactions;
    _searchController.addListener(_filterTransactions);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterTransactions() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredTransactions = _allTransactions;
      } else {
        _filteredTransactions = _allTransactions.where((transaction) {
          return transaction.name.toLowerCase().contains(query) ||
              transaction.date.toLowerCase().contains(query) ||
              transaction.amount.contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ProviderHelper.watch(themeProvider) == AppThemeMode.dark;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchField(controller: _searchController),
          SizedBox(height: 24),
          SizedBox(
            height: 100,
            width: double.infinity,
            child: AppContainer(
              color: isDark
                  ? ColorConfig.surfaceDark
                  : ColorConfig.surfaceLight,
              borderRadius: BorderRadius.circular(8),
              child: Center(child: Text("NGN 80000")),
            ),
          ),
          SizedBox(height: 24),
          QuickActionsSection(),
          SizedBox(height: 32),
          RecentTransactionsSection(
            isExpanded: _isExpanded,
            onToggle: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            transactions: _filteredTransactions,
          ),
        ],
      ),
    );
  }
}
