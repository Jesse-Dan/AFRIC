// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet/src/config/color_config.dart';
import 'package:wallet/src/providers/auth_provider.dart';
import 'package:wallet/src/providers/transaction_provider.dart';
import 'package:wallet/src/reusables/components/app_container.dart';
import 'package:wallet/src/reusables/extensions/context.dart';
import 'package:wallet/src/reusables/extensions/string.dart';

class BalanceCard extends ConsumerStatefulWidget {
  const BalanceCard({super.key, required this.isDark});

  final bool isDark;

  @override
  ConsumerState<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends ConsumerState<BalanceCard> {
  bool _isRefreshing = false;

  Future<void> _refreshBalance() async {
    if (_isRefreshing) return;

    setState(() => _isRefreshing = true);

    try {
      await ref.read(transactionProvider).refreshBalance();
    } finally {
      if (mounted) {
        setState(() => _isRefreshing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProv = ref.watch(authProvider);
    final transProv = ref.watch(transactionProvider);

    final balanceString = authProv.user?.account?.balance ?? '0.00';
    final formattedBalance = balanceString.formatAmount();

    final currency = authProv.user?.account?.currency ?? 'NGN';

    return Visibility(
      visible: transProv.searchController.text.isEmpty,
      child: Padding(
        padding: EdgeInsets.only(bottom: 32),
        child: SizedBox(
          height: 130,
          width: double.infinity,
          child: AppContainer(
            color: widget.isDark
                ? ColorConfig.surfaceDark
                : ColorConfig.surfaceLight,
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Available Balance',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: widget.isDark
                              ? Colors.white.withOpacity(0.7)
                              : Colors.black.withOpacity(0.6),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            currency,
                            style: context.textTheme.titleMedium?.copyWith(
                              color: widget.isDark
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            formattedBalance,
                            style: context.textTheme.headlineLarge?.copyWith(
                              color: widget.isDark
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    onPressed: _isRefreshing ? null : _refreshBalance,
                    icon: _isRefreshing
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                widget.isDark
                                    ? Colors.white.withOpacity(0.7)
                                    : Colors.black.withOpacity(0.6),
                              ),
                            ),
                          )
                        : Icon(
                            Icons.refresh_rounded,
                            color: widget.isDark
                                ? Colors.white.withOpacity(0.7)
                                : Colors.black.withOpacity(0.6),
                            size: 20,
                          ),
                    tooltip: 'Refresh balance',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
