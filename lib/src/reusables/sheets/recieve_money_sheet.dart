import 'package:flutter/material.dart';
import 'package:wallet/src/config/color_config.dart';
import 'package:wallet/src/reusables/components/app_buttom_sheet.dart';
import 'package:wallet/src/reusables/components/app_text_field.dart';

class ReceiveFundsSheet extends StatefulWidget {
  const ReceiveFundsSheet({super.key});

  @override
  State<ReceiveFundsSheet> createState() => _ReceiveFundsSheetState();
}

class _ReceiveFundsSheetState extends State<ReceiveFundsSheet> {
  final TextEditingController _amountController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

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

  void _handleReceive() {
    final amount = double.tryParse(_amountController.text);
    if (amount != null && amount > 0) {
      Navigator.pop(context, amount);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please enter a valid amount')));
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
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_downward_rounded,
                  color: Colors.green,
                  size: 24,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Receive Money',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? ColorConfig.textLight
                            : ColorConfig.textDark,
                      ),
                    ),
                    Text(
                      'Enter amount to receive',
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorConfig.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close, color: ColorConfig.textSecondary),
              ),
            ],
          ),
          SizedBox(height: 32),
          AppTextField(
            controller: _amountController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            label: 'Amount',
            hintText: '0.00',
            prefixIcon: Icons.send,
          ),
          SizedBox(height: 24),
          QuickAmountButtons(
            onAmountSelected: (amount) {
              _amountController.text = amount.toString();
            },
          ),
          SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _handleReceive,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_downward_rounded),
                  SizedBox(width: 8),
                  Text(
                    'Request Money',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
