class FavoritesModel {
  FavoritesModel({
    required this.status,
    required this.data,
  });

  bool status;
  Data data;

  factory FavoritesModel.fromJson(Map<String, dynamic> json) => FavoritesModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

}

class Data {
  Data({
    required this.data,
  });

  List<Datum> data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );
}

class Datum {
  Datum({
    required this.id,
    required this.product,
  });

  int id;
  Product product;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    product: Product.fromJson(json["product"]),
  );

}

class Product {
  Product({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
  });

  int id;
  int price;
  int oldPrice;
  int discount;
  String image;
  String name;
  String description;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    price: json["price"],
    oldPrice: json["old_price"],
    discount: json["discount"],
    image: json["image"],
    name: json["name"],
    description: json["description"],
  );

}
