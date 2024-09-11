import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;
  final List likes;

  Post(
      {required this.description,
      required this.uid,
      required this.username,
      required this.postId,
      required this.datePublished,
      required this.postUrl,
      required this.profImage,
      required this.likes});

  Map<String, dynamic> toJson() => {
        'username': username,
        'description': description,
        'postId': postId,
        'uid': uid,
        'datePublished': datePublished,
        'postUrl': postUrl,
        'profImage': profImage,
        'likes': likes
      };

  static Post fromSnapshot(DocumentSnapshot snap) {
    return Post(
        username: snap.get('username'),
        description: snap.get('description'),
        postId: snap.get('postId'),
        uid: snap.get('uid'),
        datePublished: snap.get('datePublished'),
        postUrl: snap.get('postUrl'),
        profImage: snap.get('profImage'),
        likes: snap.get('likes'));
  }
}
