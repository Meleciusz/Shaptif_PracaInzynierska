import 'package:cloud_firestore/cloud_firestore.dart';
import '../../exercise_repository.dart';

class FirestoreService {
  final CollectionReference _exerciseCollection =
  FirebaseFirestore.instance.collection('Exercise');

  Stream<List<Exercise>> getExercises() {
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
      }
    );
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