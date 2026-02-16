import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet/src/reusables/utils/storage_util.dart';
import 'package:wallet/wallet_initilizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await SystemChannels.textInput.invokeMethod('TextInput.hide');

  await StorageUtil.instance.init();

  runApp(const ProviderScope(child: AppInitializer()));
}
