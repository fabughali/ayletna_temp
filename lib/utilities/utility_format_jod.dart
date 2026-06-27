/// JOD formatting (PRD — Jordan currency).
abstract final class UtilityFormatJod {
  static String format(double amount, {String suffix = 'د.أ'}) {
    return '${amount.toStringAsFixed(2)} $suffix';
  }
}
