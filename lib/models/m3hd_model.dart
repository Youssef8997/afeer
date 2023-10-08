
class M3hdModel{
  final String? alerts;
  final String name;
  final String? videoLink;
  final List<String>?pdfLinks;

  M3hdModel(  {this.alerts,  this.videoLink,  this.pdfLinks,required this.name,});
  factory M3hdModel.fromJson(Map<String,dynamic>json)=>M3hdModel(
    name: json["name"],
    alerts: json["alerts"],
    pdfLinks: List.generate(json["pdfLinks"]!=null?json["pdfLinks"].length:0, (index) => json["pdfLinks"][index]),
    videoLink: json["videoLink"],

  );
  Map<String,dynamic>toMap()=>{
    "name":name,

  };
}