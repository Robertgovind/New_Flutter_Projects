import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee/pages/add_employee.dart';
import 'package:employee/services/database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stream? empStream;

  getData() async {
    empStream = await DatabaseMethod().getEmployee();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Widget allEmpDetails() {
    return StreamBuilder(
        stream: empStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 2),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name : ${ds["name"]}",
                            style: const TextStyle(
                                fontSize: 24,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Age : ${ds["age"]}",
                            style: const TextStyle(
                                fontSize: 24,
                                color: Colors.orange,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Location : ${ds["location"]}",
                            style: const TextStyle(
                                fontSize: 24,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return const AddEmployeeInfo();
            }),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.orange,
        ),
      ),
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Flutter",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Firebase",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            Expanded(
              child: allEmpDetails(),
            ),
          ],
        ),
      ),
    );
  }
}
