import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finstagram/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  double? _deviceHeight, _deviceWidth;
  FirebaseService? firebaseService;

  @override
  void initState() {
    super.initState();
    firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.height;
    return Container(
      height: _deviceHeight,
      width: _deviceWidth,
      child: _postListView(),
    );
  }

  Widget _postListView() {
    return StreamBuilder<QuerySnapshot>(
      stream: firebaseService!.getLatestPost(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List posts = snapshot.data!.docs.map((e) => e.data()).toList();
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              Map post = posts[index];
              return Container(
                height: _deviceHeight! * 0.30,
                margin: EdgeInsets.symmetric(
                    vertical: _deviceHeight! * 0.01,
                    horizontal: _deviceWidth! * 0.02),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        post['image'],
                      ),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(12),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
