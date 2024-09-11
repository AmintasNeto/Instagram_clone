import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive/pages/feed_page.dart';
import 'package:instagram_clone/responsive/pages/profile_page.dart';
import 'package:instagram_clone/responsive/pages/search_page.dart';
import '../responsive/pages/add_post_page.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedPage(),
  const SearchPage(),
  const AddPostPage(),
  const Center(
    child: Text("notify (Coming soon)"),
  ),
  ProfilePage(uid: FirebaseAuth.instance.currentUser!.uid,),
];