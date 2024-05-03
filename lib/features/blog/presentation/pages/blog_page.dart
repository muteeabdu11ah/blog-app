import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:get/get.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog App'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  AddNewBlogPage.route(),
                );
              },
              icon: const Icon(CupertinoIcons.add_circled))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DottedBorder(
              //color: ,
              //dashPattern: [10,4],
              radius:const Radius.circular(10),
              borderType: BorderType.RRect,
              strokeCap: StrokeCap.round,
                child: Container(
              height: MediaQuery.of(context).size.height / 0.25,
              width: double.infinity,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.folder_open,
                    size: 40,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Select Your Image',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
