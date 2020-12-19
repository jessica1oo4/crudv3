class AppUser {
  final String uid;

  AppUser({this.uid});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
    };
  }
}
