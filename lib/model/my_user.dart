class MyUser{
  static const String collectionName = "users";
  String? name;
  String? email;
  String? id;
  MyUser({required this.id , required this.name , required this.email});

  MyUser.fromFireStore(Map<String , dynamic> data):
      this(
        id: data['id'] as String,
        email: data['email'] as String,
        name: data['name'] as String,

      );

  Map<String , dynamic> toFireStore(){
    return {
      'id' : id,
      'email' : email,
      'name' : name
    };
  }
}