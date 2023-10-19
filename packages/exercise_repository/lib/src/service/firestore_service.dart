import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../exercise_repository.dart';



class FirestoreExerciseService {
  FirestoreExerciseService(){
   _checkInternetConnection();
  }

  Future<void> _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {

      await clearFirestoreCache();
    }
  }

  Future<void> clearFirestoreCache() async {
    try {
      await FirebaseFirestore.instance.clearPersistence();
    } catch (e) {
      print('Błąd podczas czyszczenia pamięci podręcznej Firestore: $e');
    }
  }

  final CollectionReference _exerciseCollection =
  FirebaseFirestore.instance.collection('Exercise');

  Future<List<Exercise>> getExercises() async {
    final querySnapshot = await _exerciseCollection.get();
    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      List<String> bodyPartsList = List<String>.from(data['body_part_id']);
      return Exercise(
        id: doc.id,
        body_parts: bodyPartsList,
        photo_url: data['photo_url'],
        name: data['name'],
        description: data['description'],
        veryfied: data['veryfied'],
        adding_user_id: data['adding_user_id'],
      );
    }).toList();
  }

  Future<List<Exercise>> getExercisesByCategory(String category) async{
    final querySnapshot = await _exerciseCollection
        .where('body_part_id', arrayContains: category)
        .get();

    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      List<String> bodyPartsList = List<String>.from(data['body_part_id']);

      return Exercise(
        id: doc.id,
        body_parts: bodyPartsList,
        photo_url: data['photo_url'],
        name: data['name'],
        description: data['description'],
        veryfied: data['veryfied'],
        adding_user_id: data['adding_user_id'],
      );
    }).toList();
  }

  Future<List<Exercise>> getVerifiedExercises() async {
    final querySnapshot = await _exerciseCollection.where('veryfied', isEqualTo: true).get();
    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      List<String> bodyPartsList = List<String>.from(data['body_part_id']);
      return Exercise(
        id: doc.id,
        body_parts: bodyPartsList,
        photo_url: data['photo_url'],
        name: data['name'],
        description: data['description'],
        veryfied: data['veryfied'],
        adding_user_id: data['adding_user_id'],
      );
    }).toList();
  }

  Future<void> addExercise(Exercise exercise) {
    return _exerciseCollection.add({
      'body_part_id': exercise.body_parts,
      'photo_url': exercise.photo_url,
      'name': exercise.name,
      'description': exercise.description,
      'veryfied': exercise.veryfied,
      'adding_user_id': exercise.adding_user_id
    });
  }

  Future<void> updateExercise(Exercise exercise) {
    return _exerciseCollection.doc(exercise.id).update({
      'body_part_id': exercise.body_parts,
      'photo_url': exercise.photo_url,
      'name': exercise.name,
      'description': exercise.description,
      'veryfied': exercise.veryfied,
      'adding_user_id': exercise.adding_user_id
    });
  }

  Future<void> deleteExercise(String id) {
    return _exerciseCollection.doc(id).delete();
  }
}