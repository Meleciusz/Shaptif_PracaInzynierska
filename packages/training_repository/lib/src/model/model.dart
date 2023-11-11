class Training{
  String id;
  String name;
  String addingUserId;
  String addingUserName;
  List<String> exercises;
  String description;
  List<String> startingWeight;
  String mainlyUsedBodyPart;
  bool verified;
  List<String> allBodyParts;
  List<bool> isFinished;

  Training({
    required this.id,
    required this.name,
    required this.addingUserId,
    required this.addingUserName,
    required this.exercises,
    required this.description,
    required this.startingWeight,
    required this.mainlyUsedBodyPart,
    required this.verified,
    required this.allBodyParts,
    required this.isFinished
  });

  Training copyWith({
    String? id,
    String? name,
    String? addingUserId,
    String? addingUserName,
    List<String>? exercises,
    String? description,
    List<String>? startingWeight,
    String? mainlyUsedBodyPart,
    bool? verified,
    List<String>? allBodyParts,
    List<bool>? isFinished
  }){
    return Training(
      id: id ?? this.id,
      name: name ?? this.name,
      addingUserId: addingUserId ?? this.addingUserId,
      addingUserName: addingUserName ?? this.addingUserName,
      exercises: exercises ?? this.exercises,
      description: description ?? this.description,
      startingWeight: startingWeight ?? this.startingWeight,
      mainlyUsedBodyPart: mainlyUsedBodyPart ?? this.mainlyUsedBodyPart,
      verified: verified ?? this.verified,
      allBodyParts: allBodyParts ?? this.allBodyParts,
      isFinished: isFinished ?? this.isFinished
    );
  }
}