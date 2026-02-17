import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet/src/config/color_config.dart';
import 'package:wallet/src/providers/transaction_provider.dart';
import 'package:wallet/src/reusables/components/app_buttom_sheet.dart';
import 'package:wallet/src/reusables/components/app_text_field.dart';
import 'package:wallet/src/reusables/utils/show_text.dart';

class SendFundsSheet extends ConsumerStatefulWidget {
  const SendFundsSheet({super.key});

  @override
  ConsumerState<SendFundsSheet> createState() => _SendFundsSheetState();
}

class _SendFundsSheetState extends ConsumerState<SendFundsSheet> {
  final TextEditingController _amountController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _handleSend() async {
    final amount = double.tryParse(_amountController.text);

    if (amount == null || amount <= 0) {
      showText('Please enter a valid amount');
      return;
    }

    setState(() => _isProcessing = true);

    try {
      await ref.read(transactionProvider).debit(amount.toInt());

      if (mounted) {
        Navigator.pop(context, amount);
        showText('Successfully sent ₦${amount.toStringAsFixed(2)}');
      }
    } catch (e) {
      if (mounted) {
        showText('Failed to send money: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_upward_rounded,
                  color: Colors.red,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Send Money',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? ColorConfig.textLight
                            : ColorConfig.textDark,
                      ),
                    ),
                    const Text(
                      'Enter amount to send',
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorConfig.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: _isProcessing ? null : () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: ColorConfig.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 32),
          AppTextField(
            controller: _amountController,
            focusNode: _focusNode,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            label: 'Amount',
            hintText: '0.00',
            prefixIcon: Icons.send,
            enabled: !_isProcessing,
          ),
          const SizedBox(height: 24),
          QuickAmountButtons(
            onAmountSelected: (amount) {
              if (!_isProcessing) {
                _amountController.text = amount.toString();
              }
            },
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isProcessing ? null : _handleSend,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.red.withOpacity(0.5),
              ),
              child: _isProcessing
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.arrow_upward_rounded),
                        SizedBox(width: 8),
                        Text(
                          'Send Money',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
