import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;

  User(
      {required this.email,
      required this.uid,
      required this.photoUrl,
      required this.username,
      required this.bio,
      required this.followers,
      required this.following});

  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
    'bio': bio,
    'uid': uid,
    'photoUrl': photoUrl,
    'followers': followers,
    'following': following
  };

  static User fromSnapshot(DocumentSnapshot snap) {
    return User(
      username: snap.get('username'),
      email: snap.get('email'),
      bio: snap.get('bio'),
      uid: snap.get('uid'),
      photoUrl: snap.get('photoUrl'),
      followers: snap.get('followers'),
      following: snap.get('following')
    );
  }
}
