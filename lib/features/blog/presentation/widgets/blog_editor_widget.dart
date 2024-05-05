import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {
  final TextEditingController textcontroller;
  final String hintText;

  const BlogEditor(
      {super.key, required this.textcontroller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textcontroller,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            width: 2,
            color: Color.fromARGB(255, 9, 148, 20), // Initial border color
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.grey, // Default border color
          ),
        ),
      ),
      cursorColor: Colors.black, 
      maxLines: null,
    );
  }
}
