class BodyParts{
  int id;
  String part;

  BodyParts({
    required this.id,
    required this.part,
  });

  BodyParts copyWith({
    int? id,
    String? part,
  }){
    return BodyParts(
      id: id ?? this.id,
      part: part ?? this.part
    );
  }
}