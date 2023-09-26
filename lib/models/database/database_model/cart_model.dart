class Cart {
  late final int id;
  String productId;
  String productName;
  int intialPrize;
  int productPrize;
  int quantity;
  String unitTag;
  String image;

  Cart(
      {required this.id,
      required this.productId,
      required this.productName,
      required this.intialPrize,
      required this.productPrize,
      required this.quantity,
      required this.unitTag,
      required this.image});

  Cart.fromMap(Map<dynamic, dynamic> res)
      : id = res["id"],
        productId = res["productId"],
        productName = res["productName"],
        intialPrize = res["intialPrize"],
        productPrize = res["productPrize"],
        quantity = res["quantity"],
        unitTag = res["unitTag"],
        image = res["image"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "productId": productId,
      "productName": productName,
      "intialPrize ": intialPrize,
      "productPrize": productPrize,
      "quantity": quantity,
      "unitTag": unitTag,
      "image": image
    };
  }
}
