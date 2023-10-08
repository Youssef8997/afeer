
class SubModel{
  final String name;
  final String? id;
  final String det;
  final String price;
  final bool isASingleSubject;
  final List? singleSubject;
  final bool isAllAvailable;
  final List?notAvailable;

  SubModel(
      {required this.name,
        required this.det,
        this.singleSubject,
        this.id,
        required this.price,
        required this.isASingleSubject,
        required this.isAllAvailable,
        this.notAvailable});
  factory SubModel.fromJson(Map<String,dynamic>json)=>SubModel(
    name: json["name"],
    det: json["det"],
    price: json["price"],
    id: json["id"],
    isASingleSubject: json["isASingleSubject"],
    isAllAvailable: json["isAllAvailable"],
    notAvailable: json["notAvailable"],
    singleSubject: json["singleSubject"],
  );
  Map<String,dynamic>toMap(id)=>{
    "name":name,
    "id":id,
    "det":det,
    "price":price,
    "isASingleSubject":isASingleSubject,
    "isAllAvailable":isAllAvailable,
    "notAvailable":notAvailable,
    "singleSubject":singleSubject,
  };
}