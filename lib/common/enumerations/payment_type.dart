class PaymentType {
  static const cash = PaymentType._(0);
  static const creditCard = PaymentType._(1);
  static const checks = PaymentType._(2);

  static List<PaymentType> get values => [
        cash,
        creditCard,
        checks,
      ];

  String translate() {
    switch (index) {
      case 0:
        return "cash";
      case 1:
        return "creditCard";
      case 2:
        return "checks";
      default:
        return " ";
    }
  }

  final int index;

  const PaymentType._(this.index);
  static List<int> get indexes => values.map<int>((x) => x.index).toList();
  static PaymentType getValue(int index) => PaymentType._(index);
}
