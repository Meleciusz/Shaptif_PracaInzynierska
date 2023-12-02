import 'package:cloud_firestore/cloud_firestore.dart';

/*
History - represent history, that is created when training is done
 */
class History{

  //id of history - unique identifier
  String id;

  //name of history element
  String name;

  //id of user that added history
  String adding_user_id;

  //name of user that added history
  String adding_user_name;

  //name of exercises made in training
  List<String> exercises_name;

  //number of sets for each exercise
  List<int> exercises_sets_count;

  //weights for each exercise
  List<String> exercises_weights;

  //date when training was done
  Timestamp date;


  History({
    required this.id,
    required this.name,
    required this.adding_user_id,
    required this.adding_user_name,
    required this.exercises_name,
    required this.exercises_sets_count,
    required this.exercises_weights,
    required this.date
  });

  History copyWith({
    id,
    name,
    adding_user_id,
    adding_user_name,
    exercises_name,
    exercises_sets_count,
    exercises_weights,
    date

  }){
    return History(
        id: id,
        name: name,
        adding_user_id: adding_user_id,
        adding_user_name: adding_user_name,
        exercises_name: exercises_name,
        exercises_sets_count: exercises_sets_count,
        exercises_weights: exercises_weights,
        date: date
    );
  }
}