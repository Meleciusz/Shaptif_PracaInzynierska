/*
  *Main description:
This class represent object that can be returned from training play
 */
class Return {

  // body part that is used the most
  String mainlyUsedBodyPart;

  //all used body parts
  List<String> allBodyParts;

  // all exercises that was made
  List<String> exercisesNames;

  // is exercises done
  List<bool> isFinished;

  // all exercises weights
  List<String> exercisesWeights;

  // all exercises sets
  List<int> exercisesSetsCount;

  // do user want to save as a new training
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