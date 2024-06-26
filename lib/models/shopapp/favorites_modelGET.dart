class FavoritesModel {
  bool? status;
  //Null? message;
  DataFavorites? data;
  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
 //   message = json['message'];
    data =  DataFavorites.fromJson(json['data']) ;
  }
}

class DataFavorites {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
//  Null? nextPageUrl;
  String? path;
  int? perPage;
//  Null? prevPageUrl;
  int? to;
  int? total;
  DataFavorites.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
  //  nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
   // prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class Data {
  int? id;
  Product? product;

  Data({this.id, this.product});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = Product.fromJson(json['product']);
  }

}

class Product {
  int? id;
  dynamic? price;
  dynamic? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;


  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }


}
