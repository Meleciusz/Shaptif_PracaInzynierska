/*
BodyParts - define body parts that can be trained in exercises
 */
class BodyParts{
  //id of body part - unique identifier
  int id;

  //name of body part
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