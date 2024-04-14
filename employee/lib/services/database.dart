import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod {
  Future addEmployeeDetails(
      Map<String, dynamic> employeeInfo, String id) async {
    return await FirebaseFirestore.instance.collection('Employee').doc(id);
  }
}
