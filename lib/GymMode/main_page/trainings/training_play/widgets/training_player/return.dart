class Return {
  String mainlyUsedBodyPart;
  List<String> allBodyParts;
  List<String> exercisesNames;
  List<bool> isFinished;

  List<String> exercisesWeights;
  List<int> exercisesSetsCount;
  bool wantToSave;

  Return({
    required this.mainlyUsedBodyPart,
    required this.allBodyParts,
    required this.exercisesNames,
    required this.isFinished,

    required this.exercisesWeights,
    required this.exercisesSetsCount,
    required this.wantToSave
  });

  Return copyWith({
    mainlyUsedBodyPart,
    allBodyParts,
    exercisesNames,
    isFinished,

    exercisesWeights,
    exercisesSetsCount,
    wantToSave
  }){
    return Return(
      mainlyUsedBodyPart: mainlyUsedBodyPart,
      allBodyParts: allBodyParts,
      exercisesNames: exercisesNames,
      isFinished: isFinished,

      exercisesWeights: exercisesWeights,
      exercisesSetsCount: exercisesSetsCount,
      wantToSave: wantToSave
    );
  }
}