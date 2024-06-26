import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {
  final TextEditingController textcontroller;
  final String hintText;

  const BlogEditor(
      {super.key, required this.textcontroller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.trim().isEmpty) {
          return '$hintText is missing';
        }
        return null;
      },
      controller: textcontroller,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:
              BorderSide(width: 2, color: Colors.blue // Initial border color
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
