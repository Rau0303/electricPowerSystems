class userModel{
  String name;
  String email;
  String profilePicture;
  String phoneNumber;
  String uid;
  String createdAt;

  userModel({
    required this.name,
    required this.email,
    required this.profilePicture,
    required this.phoneNumber,
    required this.uid,
    required this.createdAt
  });

  factory userModel.fromMap(Map<String, dynamic> map){
    return userModel(
        name: map['name']?? '',
        email: map['email']?? '',
        profilePicture: map['profilePicture']?? '',
        phoneNumber: map['phoneNumber']?? '',
        uid: map['uid']?? '',
        createdAt: map['createdAt']?? '',
    );
  }

  Map<String,dynamic> toMap(){
    return {
      "name": name,
      "email": email,
      "uid": uid,
      "profilePicture":profilePicture,
      "phoneNumber":phoneNumber,
      "createdAt":createdAt,
    };
  }
}

