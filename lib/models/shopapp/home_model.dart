class HomeModel
{
 late bool status;
late  HomeDataModel data;
HomeModel.forjson(Map<String,dynamic> json){
  status=json['status'];
  data=HomeDataModel.forjson(json["data"]);
}
}
class HomeDataModel{
  List<BannersModel>banner=[];
  List<ProductsModel>product=[];
HomeDataModel.forjson(Map<String,dynamic> json){
  json['banners'].forEach((element) {
    banner.add(BannersModel.forJson(element));
  });

json['products'].forEach((element){
  product.add(ProductsModel.forjson(element));
});
}
}
class BannersModel {
  int? id;
  String? image;

  BannersModel.forJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    image = json['image'] as String?;
  }
}
class ProductsModel{
 late int id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String? name;
  String? image;
  bool? in_cart;
 late bool in_favorites;
  ProductsModel.forjson(Map<String,dynamic> json){
id=json['id'];
price=json['price'];
old_price=json['old_price'];
discount=json['discount'];
name=json['name'];
image=json['image'];
in_cart=json['in_cart'];
in_favorites=json['in_favorites'];
  }
}