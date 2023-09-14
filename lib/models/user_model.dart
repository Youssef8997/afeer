class UserModel{
  final String name;
  final String image;
  final String phone;
  final String team;
  final String typeStudy;
  final String token;
  final String university;
  final bool eg;

  UserModel(
      {required this.name,
      required this.image,
      required this.phone,
      required this.team,
      required this.typeStudy,
      required this.token,
      required this.university,
      required this.eg});
  factory UserModel.fromJson(Map<String,dynamic>json)=>UserModel(
    phone: json["phone"],
    name: json["name"],
    image: json["image"],
    team: json["team"],
    typeStudy: json["typeStudy"],
    token: json["token"],
    university: json["university"],
    eg: json["eg"],
  );
  Map<String,dynamic>toMap()=>{
    "phone":phone,
    "name":name,
    "image":image,
    "typeStudy":typeStudy,
    "token":token,
    "university":university,
    "eg":eg,
    "team":team
  };
}