import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finstagram/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    _deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      height: _deviceHeight,
      width: _deviceWidth,
      padding: EdgeInsets.symmetric(
        horizontal: _deviceWidth! * 0.05,
        vertical: _deviceHeight! * 0.02,
      ),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _circularImage(),
          _postsOnProfile(),
        ],
      ),
    );
  }

  Widget _circularImage() {
    return Container(
      margin: EdgeInsets.only(bottom: _deviceHeight! * 0.02),
      height: _deviceHeight! * 0.15,
      width: _deviceWidth! * 0.15,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            firebaseService!.currentUser!["image"],
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }

  Widget _postsOnProfile() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: firebaseService!.getPostForUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List posts = snapshot.data!.docs.map((e) => e.data()).toList();
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                Map post = posts[index];
                return Container(
                  height: _deviceHeight! * 0.25,
                  width: _deviceWidth! * 0.30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        post["image"],
                      ),
                      fit: BoxFit.cover,
                    ),
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
      ),
    );
  }
}
