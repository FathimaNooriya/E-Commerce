class ProductModel {
  String? id;
  String? title;
  num? price;
  String? category;
  String? description;
  String? image;
  bool? favorite;
  int? productCount;
  ProductModel(
      {this.id,
      this.title,
      this.price,
      this.category,
      this.description,
      this.image,
      this.favorite,
      this.productCount});

  ProductModel.fromJson(Map<String, dynamic> json, String idProduct) {
    title = json['ProductName'] as String;
    price = json['Price'] as num;
    category = json['Category'] as String;
    description = json['Description'] as String;
    image = json['Product Image1'] as String;
    favorite = json['Favorite'] as bool;
    productCount = json['Product count'] as int;
    id = idProduct;
  }

  Map<String, dynamic> toJson() {
    return {
      'ProductName': title,
      'Price': price,
      'Category': category,
      'Description': description,
      'Product Image1': image,
      'Favorite': favorite,
      'Product count': productCount,
      'id': id,
    };
  }

  // static List<StoreModel> toListProducts(List<dynamic> jsonList) {
  //   return jsonList.map((e) => StoreModel.fromJson(e)).toList();
  // }
}
