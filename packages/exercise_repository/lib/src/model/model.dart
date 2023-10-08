class Exercise{
  String id;
  List<String> body_parts;
  String photo_url;
  String name;
  String description;
  bool veryfied;
  String adding_user_id;

  Exercise({
    required this.id,
    required this.body_parts,
    required this.photo_url,
    required this.name,
    required this.description,
    required this.veryfied,
    required this.adding_user_id
  });

  Exercise copyWith({
    String? id,
    List<String>? body_parts,
    String? photo_url,
    String? name,
    String? description,
    bool? veryfied,
    String? adding_user_id
  }){
    return Exercise(
      id: id ?? this.id,
      body_parts: body_parts ?? this.body_parts,
      photo_url: photo_url ?? this.photo_url,
      name: name ?? this.name,
      description: description ?? this.description,
      veryfied: veryfied ?? this.veryfied,
      adding_user_id: adding_user_id ?? this.adding_user_id
    );
  }
}