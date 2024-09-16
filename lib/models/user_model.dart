class Myuser {
  static const String collectionName = 'users';
  String? id;
  String? email;
  Myuser({this.id, this.email,});

  Myuser.fromFirestore(Map<String, dynamic>? data) {
    id = data!['id'] as String?;
    email = data['email'] as String?;
  }
  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'email': email,
    };
  }
}