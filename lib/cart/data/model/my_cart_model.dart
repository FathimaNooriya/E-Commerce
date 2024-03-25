class MyCartModel {
  int itemCount;
  String productId;
  String date;
  MyCartModel(
      {required this.itemCount, required this.productId, required this.date});

  factory MyCartModel.fromJson(Map<String, dynamic> json) {
    return MyCartModel(
        itemCount: json["Item_Count"] as int,
        productId: json["Product_Id"] as String,
        date: json["Date"] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'Item_Count': itemCount,
      'Product_Id': productId,
      'Date': date,
    };
  }
}
