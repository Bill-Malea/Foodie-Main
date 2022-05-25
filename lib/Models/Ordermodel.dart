class OrderModel {
  String orderNumber;
  double totalPrice;
  int totalQuantity;
  String address;
  String phoneNumber;
  String nameCustomer;
  String orderStatus;
  DateTime dateTime;

  OrderModel(
      this.orderNumber,
      this.totalPrice,
      this.totalQuantity,
      this.address,
      this.phoneNumber,
      this.nameCustomer,
      this.orderStatus,
      this.dateTime);
}
