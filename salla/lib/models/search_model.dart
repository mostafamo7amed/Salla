class SearchModel {
  SearchModel({
    required this.status,
    required this.data,
  });

  bool status;
  Data data;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

}

class Data {
  Data({
    required this.data,
  });

  List<Product> data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
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
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
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
