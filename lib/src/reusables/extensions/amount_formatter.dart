extension AmountFormatter on num {
  String formatAmount() {
    if (this >= 1000000) {
      double value = this / 1000000;
      return value % 1 == 0 ? '${value.toInt()}M' : '${value.toStringAsFixed(1)}M';
    } else if (this >= 1000) {
      double value = this / 1000;
      return value % 1 == 0 ? '${value.toInt()}K' : '${value.toStringAsFixed(1)}K';
    } else {
      return toStringAsFixed(0);
    }
  }
}
