class CategoryModel {
  bool? status;
  CategoryDataModel? data;
  CategoryModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = CategoryDataModel.formJson(json['data']);
  }

}
class CategoryDataModel {
  int? currentPage;
  List<CatDataOfDataModel>? data =[];
  CategoryDataModel.formJson(Map<String ,dynamic> json){
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data!.add(CatDataOfDataModel.fromJson(element));
    });
  }

}
class CatDataOfDataModel {
  int? id;
  String? name;
  String? image;
  CatDataOfDataModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

}