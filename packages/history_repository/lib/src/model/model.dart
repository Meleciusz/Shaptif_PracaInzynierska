class History{
  String id;
  String name;
  // String adding_user_id;
  // String adding_user_name;
  // List<String> exercises_name;
  // List<int> exercises_sets_count;
  // List<int> exercises_weights;
  // String date;


  History({
    required this.id,
    required this.name,
    // required this.adding_user_id,
    // required this.adding_user_name,
    // required this.exercises_name,
    // required this.exercises_sets_count,
    // required this.exercises_weights,
    // required this.date
  });

  History copyWith({
    id,
    name,
    // adding_user_id,
    // adding_user_name,
    // exercises_name,
    // exercises_sets_count,
    // exercises_weights,
    // date

  }){
    return History(
        id: id,
        name: name,
        // adding_user_id: adding_user_id,
        // adding_user_name: adding_user_name,
        // exercises_name: exercises_name,
        // exercises_sets_count: exercises_sets_count,
        // exercises_weights: exercises_weights,
        // date: date
    );
  }
}