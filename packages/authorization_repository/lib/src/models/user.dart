import 'package:equatable/equatable.dart';


/*
User represents the current user that is logged in
 */
class User extends Equatable {
  const User({

    //id of the user from authorization database repository
    required this.id,

    //email of the user
    this.email,

    //name of the user
    this.name,

    //photo of the user
    this.photo,
  });

  final String id;
  final String? email;
  final String? name;
  final String? photo;

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [id, email, name, photo];
}