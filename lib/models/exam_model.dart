class ExamModel{
  final String title;
  final List answer;
  final String answerText;
  final int answerIndex;

  ExamModel({required this.title, required this.answerText, required this.answer, required this.answerIndex});
  factory ExamModel.fromJson(Map<String,dynamic>json)=>ExamModel(
    title: json["title"],
    answer: json["answer"],
    answerText: json["answerText"],
    answerIndex: json["answerIndex"],
  );
  Map<String,dynamic>toMap()=>{
    "title":title,
    "answer":answer,
    "answerText":answerText,
    "answerIndex":answerIndex,
  };
}