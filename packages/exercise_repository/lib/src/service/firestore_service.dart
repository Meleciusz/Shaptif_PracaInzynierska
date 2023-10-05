import 'package:cloud_firestore/cloud_firestore.dart';
import '../../exercise_repository.dart';


class FirestoreService {
  FirestoreService(){
    clearFirestoreCache();
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
      return Exercise(
        id: doc.id,
        body_part_id: data['body_part_id'],
        photo_url: data['photo_url'],
        name: data['name'],
        description: data['description'],
        veryfied: data['veryfied'],
        adding_user_id: data['adding_user_id'],
      );
    }).toList();
  }

  Stream<List<Exercise>> updateExercises() {
    return _exerciseCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Exercise(
          id: doc.id,
          body_part_id: data['body_part_id'],
          photo_url: data['photo_url'],
          name: data['name'],
          description: data['description'],
          veryfied: data['veryfied'],
          adding_user_id: data['adding_user_id'],
        );
      }).toList();
    });
  }

  Future<void> addExercise(Exercise exercise) {
    return _exerciseCollection.add({
      'body_part_id': exercise.body_part_id,
      'photo_url': exercise.photo_url,
      'name': exercise.name,
      'description': exercise.description,
      'veryfied': exercise.veryfied,
      'adding_user_id': exercise.adding_user_id
    });
  }

  Future<void> updateExercise(Exercise exercise) {
    return _exerciseCollection.doc(exercise.id).update({
      'body_part_id': exercise.body_part_id,
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