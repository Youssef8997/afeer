class ListMassageModel{
  final String id;
  final String tokenFirst;
  final String tokenSecond;
  final String lastMassage;

  ListMassageModel(
      {required this.id, required this.tokenFirst, required this.tokenSecond, required this.lastMassage});
  factory ListMassageModel.fromJson(Map<String,dynamic>json,lastMassage)=>ListMassageModel(
    id: json["id"],
    tokenFirst: json["tokenFirst"],
    tokenSecond: json["tokenSecond"],
    lastMassage: lastMassage,
  );

}
