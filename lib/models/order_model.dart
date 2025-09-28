class OrderModel {
  final String billSrl;
  final String status;
  final double totalPrice;
  final String date;

  OrderModel({
    required this.billSrl,
    required this.status,
    required this.totalPrice,
    required this.date,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      billSrl: json['BILL_SRL'].toString(),
      status: json['DLVRY_STATUS_FLG'].toString(),
      totalPrice: double.tryParse(json['BILL_AMT'].toString()) ?? 0.0,
      date: json['BILL_DATE'].toString(),
    );
  }
}
