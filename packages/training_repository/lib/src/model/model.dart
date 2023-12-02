
/*
Training - represents a training element
 */
class Training{

  //id of training - unique identifier
  String id;

  //name of training
  String name;

  //id of user that added training
  String addingUserId;

  //list of exercises in training
  List<String> exercises;

  //description of training
  String description;

  //mainly used body part
  String mainlyUsedBodyPart;

  //is training verified
  bool verified;

  //all body parts used in training
  List<String> allBodyParts;

  //is exercises in training finished
  List<bool> isFinished;

  Training({
    required this.id,
    required this.name,
    required this.addingUserId,
    required this.exercises,
    required this.description,
    required this.mainlyUsedBodyPart,
    required this.verified,
    required this.allBodyParts,
    required this.isFinished
  });

  Training copyWith({
    String? id,
    String? name,
    String? addingUserId,
    List<String>? exercises,
    String? description,
    String? mainlyUsedBodyPart,
    bool? verified,
    List<String>? allBodyParts,
    List<bool>? isFinished
  }){
    return Training(
      id: id ?? this.id,
      name: name ?? this.name,
      addingUserId: addingUserId ?? this.addingUserId,
      exercises: exercises ?? this.exercises,
      description: description ?? this.description,
      mainlyUsedBodyPart: mainlyUsedBodyPart ?? this.mainlyUsedBodyPart,
      verified: verified ?? this.verified,
      allBodyParts: allBodyParts ?? this.allBodyParts,
      isFinished: isFinished ?? this.isFinished
    );
  }
}