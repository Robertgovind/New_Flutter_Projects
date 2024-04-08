import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  List<String> items;
  double width;

  CustomDropDown({required this.items, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.all(7),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(53, 53, 53, 1.0),
          borderRadius: BorderRadius.circular(16)),
      child: DropdownButton(
        underline: Container(),
        value: items.first,
        items: items.map(
          (e) {
            return DropdownMenuItem(
              child: Text(e),
              value: e,
            );
          },
        ).toList(),
        onChanged: (_) {},
        dropdownColor: Color.fromRGBO(53, 53, 53, 1.0),
        style: TextStyle(color: Colors.white, fontSize: 22),
      ),
    );
  }
}
