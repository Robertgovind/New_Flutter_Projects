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
  TextEditingController? nameController = TextEditingController();
  TextEditingController? ageController = TextEditingController();
  TextEditingController? locationController = TextEditingController();
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
                        border: Border.all(
                            width: 2,
                            color: Colors.orange,
                            style: BorderStyle.solid),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Name : ${ds["name"]}",
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500),
                              ),
                              const Spacer(), //Provides maximum sapce between children
                              GestureDetector(
                                onTap: () {
                                  nameController!.text = ds["name"];
                                  ageController!.text = ds["age"];
                                  locationController!.text = ds["location"];
                                  editEmpDetails(ds["id"]);
                                },
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.orange,
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              GestureDetector(
                                onTap: () {
                                  DatabaseMethod().deleteEmpDetails(ds["id"]);
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.orange,
                                ),
                              )
                            ],
                          ),
                          Text(
                            "Age : ${ds["age"]}",
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.orange,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Location : ${ds["location"]}",
                            style: const TextStyle(
                                fontSize: 20,
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

  Future editEmpDetails(String id) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.cancel),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    const Text(
                      "Edit",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      " Details",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Name",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          border: Border.all(width: 3),
                        ),
                        child: TextField(
                          controller: nameController,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        ),
                      ),
                      const Text(
                        "Age",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          border: Border.all(width: 3),
                        ),
                        child: TextField(
                          controller: ageController,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        ),
                      ),
                      const Text(
                        "Location",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          border: Border.all(width: 3),
                        ),
                        child: TextField(
                          controller: locationController,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      Map<String, dynamic> updated = {
                        "name": nameController!.text,
                        "age": ageController!.text,
                        "id": id,
                        "location": locationController!.text,
                      };
                      await DatabaseMethod().updateEmpDetails(updated, id).then(
                            (value) => Navigator.pop(context),
                          );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    child: const Text("Update"),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
