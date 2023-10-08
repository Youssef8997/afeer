class ChatListModel {
  final String chatId;
  final String idUser1;
  final String idUser2;
  final String lastMassage;
  final bool isPersonal;
  final bool isGroup;
  final bool isRead;

  ChatListModel({required this.chatId, required this.idUser1, required this.idUser2, required this.lastMassage, required this.isPersonal, required this.isGroup, required this.isRead});
  factory ChatListModel.fromJson(Map<String,dynamic>json)=>ChatListModel(
    chatId: json["chatId"],
    idUser1: json["idUser1"],
    idUser2: json["idUser2"],
    lastMassage: json["lastMassage"],
    isPersonal: json["isPersonal"],
    isRead: json["isRead"],
    isGroup: json["isGroup"],
  );
  Map<String,dynamic>toMap()=>{
    "chatId":chatId,
    "idUser1":idUser1,
    "idUser2":idUser2,
    "lastMassage":lastMassage,
    "isPersonal":isPersonal,
    "isRead":isRead,
    "isGroup":isGroup,
  };

}
