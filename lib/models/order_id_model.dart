class OrderIdModel {
  final int orderId;

  OrderIdModel({required this.orderId});

  factory OrderIdModel.fromJson(Map<String, dynamic> json) {
    return OrderIdModel(
      orderId: json['id'],
    );
  }
}