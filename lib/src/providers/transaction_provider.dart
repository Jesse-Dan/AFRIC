import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final transactionProvider = ChangeNotifierProvider(
  (ref) => TransactionProvider(),
);

class TransactionProvider extends ChangeNotifier {}
