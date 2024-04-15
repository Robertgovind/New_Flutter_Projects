import 'package:cloud_firestore/cloud_firestore.dart';

//CRUD OPERATION
class DatabaseMethod {
  //Create
  Future addEmployeeDetails(
      Map<String, dynamic> employeeInfo, String id) async {
    return await FirebaseFirestore.instance
        .collection('Employee')
        .doc(id)
        .set(employeeInfo);
  }

  //Read
  Future<Stream<QuerySnapshot>> getEmployee() async {
    return await FirebaseFirestore.instance.collection('Employee').snapshots();
  }

  //Update
  Future updateEmpDetails(Map<String, dynamic> info, String id) async {
    return await FirebaseFirestore.instance
        .collection("Employee")
        .doc(id)
        .update(info);
  }

  //Delete
  Future deleteEmpDetails(String id) async {
    return await FirebaseFirestore.instance
        .collection("Employee")
        .doc(id)
        .delete();
  }
}
