class MyUser{
  static const String collectionName = "users";
  String? name;
  String? email;
  String? id;
  DateTime joinedAt;
  MyUser({required this.id , required this.name , required this.email ,required this.joinedAt});

  MyUser.fromFireStore(Map<String , dynamic> data):
      this(
        id: data['id'] as String,
        email: data['email'] as String,
        name: data['name'] as String,
        joinedAt: DateTime.fromMillisecondsSinceEpoch(data['joinedAt'])

      );

  Map<String , dynamic> toFireStore(){
    return {
      'id' : id,
      'email' : email,
      'name' : name,
      'joinedAt' : joinedAt.millisecondsSinceEpoch
    };
  }
}