import 'package:afeer/models/sub_model.dart';

class UserModel{
  final String name;
  final String image;
  final String phone;
  final String team;
  final String typeStudy;
  final String token;
  final String university;
  final String field;
  final bool eg;
  final SubModel? subscription;

  UserModel(
      {required this.name,
      required this.image,
      required this.phone,
      required this.team,
      required this.field,
      required this.typeStudy,
       this.subscription,
      required this.token,
      required this.university,
      required this.eg});
  factory UserModel.fromJson(Map<String,dynamic>json)=>UserModel(
    phone: json["phone"],
    name: json["name"],
    image: json["image"],
    team: json["team"],
    typeStudy: json["typeStudy"],
    field: json["field"],
    token: json["token"],
    university: json["university"],
    subscription:json["subscription"]!=null?SubModel.fromJson(json["subscription"]):null ,
    eg: json["eg"],
  );
  Map<String,dynamic>toMap()=>{
    "phone":phone,
    "name":name,
    "image":image,
    "typeStudy":typeStudy,
    "token":token,
    "field":field,
    "university":university,
    "eg":eg,
    "team":team
  };
}