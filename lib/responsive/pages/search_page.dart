import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_clone/responsive/pages/profile_page.dart';
import 'package:instagram_clone/utils/colors.dart';

import '../../utils/global_variables.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  void dispose() {
    super.dispose();

    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: _searchController,
          decoration: const InputDecoration(
              labelText: 'Search for a user', border: InputBorder.none),
          onFieldSubmitted: (String _) {
            setState(() {
              isShowUsers = true;
            });
          },
        ),
      ),
      body: isShowUsers
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where('username',
                      isGreaterThanOrEqualTo: _searchController.text)
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(
                              uid: (snapshot.data! as dynamic).docs[index]
                                  ['uid']),
                        ),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              (snapshot.data! as dynamic).docs[index]
                                  ['photoUrl']),
                        ),
                        title: Text((snapshot.data! as dynamic).docs[index]
                            ['username']),
                      ),
                    );
                  },
                );
              },
            )
          : FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('posts')
                  .orderBy('datePublished', descending: true)
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return StaggeredGridView.countBuilder(
                  crossAxisCount: 3,
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) => Image.network(
                    (snapshot.data! as dynamic).docs[index]['postUrl'],
                    fit: BoxFit.cover,
                  ),
                  staggeredTileBuilder: (index) =>
                      MediaQuery.of(context).size.width > webScreenSize
                          ? StaggeredTile.count(
                              index % 7 == 0 ? 1 : 1, index % 7 == 0 ? 1 : 1)
                          : StaggeredTile.count(
                              index % 7 == 0 ? 2 : 1, index % 7 == 0 ? 2 : 1),
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                );
              },
            ),
    );
  }
}
