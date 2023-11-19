class FinalTokenId {
  final String token;
  FinalTokenId( {required this.token});
  factory FinalTokenId.fromJson(Map<String, dynamic> json) {
    return FinalTokenId(token: json['token']);
  }
}