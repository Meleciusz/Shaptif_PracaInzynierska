class Exercise{
  String id;
  int body_part_id;
  String photo_url;
  String name;
  String description;
  bool veryfied;
  String adding_user_id;

  Exercise({
    required this.id,
    required this.body_part_id,
    required this.photo_url,
    required this.name,
    required this.description,
    required this.veryfied,
    required this.adding_user_id
  });

  Exercise copyWith({
    String? id,
    int? body_part_id,
    String? photo_url,
    String? name,
    String? description,
    bool? veryfied,
    String? adding_user_id
  }){
    return Exercise(
      id: id ?? this.id,
      body_part_id: body_part_id ?? this.body_part_id,
      photo_url: photo_url ?? this.photo_url,
      name: name ?? this.name,
      description: description ?? this.description,
      veryfied: veryfied ?? this.veryfied,
      adding_user_id: adding_user_id ?? this.adding_user_id
    );
  }
}