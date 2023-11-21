class Exercise{
  String id;
  List<String> body_parts;
  String photo_url;
  String name;
  String description;
  bool verified;
  String adding_user_id;
  String adding_user_name;

  Exercise({
    required this.id,
    required this.body_parts,
    required this.photo_url,
    required this.name,
    required this.description,
    required this.verified,
    required this.adding_user_id,
    required this.adding_user_name
  });

  Exercise copyWith({
    String? id,
    List<String>? body_parts,
    String? photo_url,
    String? name,
    String? description,
    bool? verified,
    String? adding_user_id,
    String? adding_user_name
  }){
    return Exercise(
      id: id ?? this.id,
      body_parts: body_parts ?? this.body_parts,
      photo_url: photo_url ?? this.photo_url,
      name: name ?? this.name,
      description: description ?? this.description,
        verified: verified ?? this.verified,
      adding_user_id: adding_user_id ?? this.adding_user_id,
      adding_user_name: adding_user_name ?? this.adding_user_name
    );
  }
}