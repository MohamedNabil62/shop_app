class ShopLoginModel{
  late bool status;
  late String message;
late  UserData data;
  ShopLoginModel.formJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
      data=(json['data'] != null ? UserData.formJson(json['data']):UserData(id:12, name:"mohamed", email:"mo", phone: "01095", image:"mm", points:1, credit: 1, token:"kkk"))!;
  }
}

class UserData{
  late int id;
  late String name;
  late String phone;
  late String email;
  late String image;
  late int points;
  late int credit;
  late String token;
  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.points,
    required this.credit,
    required this.token
});
  UserData.formJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    image=json['image'];
    points=json['points'];
    credit=json['credit'];
    token=json['token'];
  }
}