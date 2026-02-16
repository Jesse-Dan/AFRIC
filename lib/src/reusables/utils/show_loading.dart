import "package:bot_toast/bot_toast.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet/src/reusables/components/app_loading_indicator.dart';
import 'package:wallet/src/reusables/utils/ref_holder.dart';

final loadiProvider = StateProvider<bool>((ref) => false);

void showLoading([String? text]) {
  ProviderHelper.read(loadiProvider.notifier).state = true;
  cancelLoading();
  BotToast.showCustomLoading(
    toastBuilder: (cancelFunc) =>
        AppLoadingIndicator(text: text?.replaceAll("Exception:", "")),
  );
}

void cancelLoading() {
  ProviderHelper.read(loadiProvider.notifier).state = false;
  BotToast.closeAllLoading();
}
