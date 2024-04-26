class CategoriesModel{
  bool? status;
  CategoriesDataModel? data;
  CategoriesModel.forjson(Map<String,dynamic>json)
  {
    status=json['status'];
    data=CategoriesDataModel.forjson(json['data']);
  }
}

class CategoriesDataModel{
  int? currentpage;
  List<DataModel>data=[];
  CategoriesDataModel.forjson(Map<String,dynamic>json)
  {
 currentpage=json['current_page'];
 json['data'].forEach((element){
   data.add(DataModel.forjson(element));
 });
  }
}

class DataModel{
  int? id;
  String? name;
  String? image;
DataModel.forjson(Map<String,dynamic>json){
id=json['id'];
name=json['name'];
image=json['image'];
}
}