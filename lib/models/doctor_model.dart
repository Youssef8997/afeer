class DoctorModel{
  final String name;
  final String description;
  final String urlPhoto;

  DoctorModel({required this.name, required this.description, required this.urlPhoto});
  factory DoctorModel.fromJson(Map<String,dynamic>json)=>DoctorModel(
    name:json["name"],
    description:json["description"],
      urlPhoto:json["urlPhoto"],
  );
  Map<String,dynamic> toMap()=>{
    "name":name,
    "description":description,
    "urlPhoto":urlPhoto
  };
}