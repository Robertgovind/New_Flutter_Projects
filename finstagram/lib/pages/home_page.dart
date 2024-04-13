import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:finstagram/pages/feed_page.dart';
import 'package:finstagram/pages/profile_page.dart';
import 'package:finstagram/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currPageIndex = 0;
  final List<Widget> _pages = const [
    FeedPage(),
    ProfilePage(),
  ];

  FirebaseService? firebaseService;

  @override
  void initState() {
    super.initState();
    firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          "Finstagram",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          GestureDetector(
            onTap: _postImage,
            child: const Icon(
              Icons.add_a_photo,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () async {
              await firebaseService!.logOut();
              Navigator.popAndPushNamed(context, '/login');
            },
            child: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buttomNavigation(),
      body: _pages[currPageIndex],
      backgroundColor: Colors.green,
    );
  }

  Widget _buttomNavigation() {
    return BottomNavigationBar(
      onTap: (value) {
        setState(() {
          currPageIndex = value;
          print(currPageIndex);
        });
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Feed"),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
          ),
          label: "Profile",
        ),
      ],
    );
  }

  void _postImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    File image = File(result!.files.first.path!);
    await firebaseService!.postImage(image);
  }
}
