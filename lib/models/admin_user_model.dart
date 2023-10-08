class AdminUserModel{
  final String name;
  final String email;
  final String pass;
  final bool isAdmin;
  final bool isChat;
  final String? uid;

  AdminUserModel(
      {required this.name, required this.email, required this.pass, required this.isAdmin,  this.uid,required this.isChat});
  factory AdminUserModel.fromJson(Map<String,dynamic>json)=>AdminUserModel(
    name: json["name"],
    email: json["email"],
    pass: json["pass"],
    isAdmin: json["isAdmin"],
    uid: json["uid"],
isChat: json["isReplier"],
  );
  Map <String,dynamic>toMap(uid)=>{
    "name":name,
    "email":email,
    "pass":pass,
    "isAdmin":isAdmin,
    "uid":uid,
    "isReplier":isChat,
  };
}