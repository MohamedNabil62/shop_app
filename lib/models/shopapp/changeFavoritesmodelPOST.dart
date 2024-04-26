class ChangeFavoritesModel{
 late bool status;
 late String message;
  ChangeFavoritesModel.forjson(Map<String,dynamic>json)
  {
    status=json["status"];
    message=json['message'];
  }
}