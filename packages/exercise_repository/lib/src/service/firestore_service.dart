import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../exercise_repository.dart';


/*
FirestoreBodyPartsService - service to make requests to Firestore
 */
class FirestoreExerciseService {
  FirestoreExerciseService(){
   _checkInternetConnection();
  }

  //function to check internet connection
  Future<void> _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {

      //if device has internet connection, clear firestore cache
      await clearFirestoreCache();
    }
  }

  //function to clear firestore cache
  Future<void> clearFirestoreCache() async {
    try {
      await FirebaseFirestore.instance.clearPersistence();
    } catch (e) {
      print('Error: $e');
    }
  }

  //reference to exercise collection
  final CollectionReference _exerciseCollection =
  FirebaseFirestore.instance.collection('Exercise');

  //function to get exercises
  Future<List<Exercise>> getExercises() async {
    final querySnapshot = await _exerciseCollection.get();
    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      List<String> bodyPartsList = List<String>.from(data['body_part_name']);
      return Exercise(
        id: doc.id,
        body_parts_name: bodyPartsList,
        photo_url: data['photo_url'],
        name: data['name'],
        description: data['description'],
        verified: data['verified'],
        adding_user_id: data['adding_user_id'],
        adding_user_name: data['adding_user_name'],
      );
    }).toList();
  }

  //function to get exercises by category
  Future<List<Exercise>> getExercisesByCategory(String category) async{
    final querySnapshot = await _exerciseCollection
        .where('body_part_name', arrayContains: category)
        .get();

    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      List<String> bodyPartsList = List<String>.from(data['body_part_name']);

      return Exercise(
        id: doc.id,
        body_parts_name: bodyPartsList,
        photo_url: data['photo_url'],
        name: data['name'],
        description: data['description'],
        verified: data['verified'],
        adding_user_id: data['adding_user_id'],
        adding_user_name: data['adding_user_name'],
      );
    }).toList();
  }

  //function to get verified exercises
  Future<List<Exercise>> getVerifiedExercises() async {
    final querySnapshot = await _exerciseCollection.where('verified', isEqualTo: true).get();
    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      List<String> bodyPartsList = List<String>.from(data['body_part_name']);
      return Exercise(
        id: doc.id,
        body_parts_name: bodyPartsList,
        photo_url: data['photo_url'],
        name: data['name'],
        description: data['description'],
        verified: data['verified'],
        adding_user_id: data['adding_user_id'],
        adding_user_name: data['adding_user_name'],
      );
    }).toList();
  }


  //function to add exercise
  Future<void> addExercise(Exercise exercise) {
    return _exerciseCollection.add({
      'body_part_name': exercise.body_parts_name,
      'photo_url': exercise.photo_url,
      'name': exercise.name,
      'description': exercise.description,
      'verified': exercise.verified,
      'adding_user_id': exercise.adding_user_id,
      'adding_user_name': exercise.adding_user_name
    });
  }

  //function to delete specific exercise
  Future<void> deleteExercise(String id) {
    return _exerciseCollection.doc(id).delete();
  }
}