class HomeModel {
  bool? status;
  HomeDataModel? data;
  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannerModel>? banners = [];
  List<ProductModel>? products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      json['banners'].forEach((element) {
        banners!.add(BannerModel.fromJson(element));
      });
    }
    if (json['products'] != null) {
      json['products'].forEach((element) {
        products!.add(ProductModel.fromJson(element));
      });
    }
  }
}

class BannerModel {
  int? id;
  String? image;
  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavourite;
  bool? inCart;
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavourite = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
