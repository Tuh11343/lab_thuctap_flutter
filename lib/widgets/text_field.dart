import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  bool isNumber;
  Function(int value) inputChanged;

  MyTextField({
    required this.isNumber,
    required this.inputChanged
  });

  @override
  State<StatefulWidget> createState() {
    return MyTextFieldState();
  }
}

class MyTextFieldState extends State<MyTextField> {

  TextEditingController controller=TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text='0';
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      maxLength: 10,
      keyboardType: widget.isNumber ? TextInputType.number : TextInputType.text,
      onChanged: (value) {
        if (value.isNotEmpty) {
          if (int.parse(value) != 0) {
            widget.inputChanged(int.parse(value));
          }
        }
      },
    );
  }
}
