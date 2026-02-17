import 'package:flutter/material.dart';
import 'package:wallet/src/modules/home/components/balance_card.dart';
import 'package:wallet/src/modules/home/components/quick_actions_section.dart';
import 'package:wallet/src/modules/home/components/recent_transactions_section.dart';
import 'package:wallet/src/modules/home/components/search_field.dart';
import 'package:wallet/src/providers/theme_provider.dart';
import 'package:wallet/src/providers/transaction_provider.dart';
import 'package:wallet/src/reusables/utils/ref_holder.dart';

class HomeContentWidget extends StatefulWidget {
  const HomeContentWidget({super.key});

  @override
  State<HomeContentWidget> createState() => _HomeContentWidgetState();
}

class _HomeContentWidgetState extends State<HomeContentWidget> {
  @override
  Widget build(BuildContext context) {
    final isDark = ProviderHelper.watch(themeProvider) == AppThemeMode.dark;
    var tranProv = ProviderHelper.watch(transactionProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchField(controller: tranProv.searchController),
          BalanceCard(isDark: isDark),
          QuickActionsSection(),
          RecentTransactionsSection(
            isExpanded: tranProv.isExpanded,
            onToggle: () {
              setState(() {
                tranProv.isExpanded = !tranProv.isExpanded;
              });
            },
            transactions: tranProv.filteredTransactions,
          ),
        ],
      ),
    );
  }
}
