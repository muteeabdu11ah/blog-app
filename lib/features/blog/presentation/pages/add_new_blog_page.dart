import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fyp/core/common/widgets/reponsive.dart';
import 'package:fyp/core/utils/pick_image.dart';
import 'package:fyp/features/blog/presentation/widgets/blog_editor_widget.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => AddNewBlogPage(),
      );
  AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titlecontroller = TextEditingController();
  final contentcontroller = TextEditingController();
  final List<String> selectedTopics = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titlecontroller.dispose();
    contentcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Blog'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  AddNewBlogPage.route(),
                );
              },
              icon: const Icon(Icons.done))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: ResponsiveHeight(context: context).scale(2),
              horizontal: ResponsiveWidth(context: context).scale(3)),
          child: Column(
            children: [
              image != null
                  ? GestureDetector(
                      onTap: pickImage,
                      child: SizedBox(
                          width: double.infinity,
                          height: ResponsiveHeight(context: context).scale(30),
                          child: SingleChildScrollView(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                image!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                    )
                  : GestureDetector(
                      onTap: () => selectImage(),
                      child: DottedBorder(
                          //color: ,
                          dashPattern: const [10, 4],
                          radius: const Radius.circular(10),
                          borderType: BorderType.RRect,
                          strokeCap: StrokeCap.round,
                          child: Container(
                            height:
                                ResponsiveHeight(context: context).scale(25),
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
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )),
                    ),
              SizedBox(
                height: ResponsiveHeight(context: context).scale(3.5),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    'health care	',
                    'advance care',
                    'Medical news',
                    'Medical technology',
                    'Pharmaceuticals',
                    'Health conditions'
                  ]
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              if (selectedTopics.contains(e)) {
                                selectedTopics.remove(e);
                              } else {
                                selectedTopics.add(e);
                              }
                              setState(() {});
                            },
                            child: Chip(
                              side: BorderSide(
                                color: selectedTopics.contains(e)
                                    ? const Color.fromARGB(0, 0, 0, 0)
                                    : Colors.black12,
                              ),
                              label: Text(e),
                              color: !selectedTopics.contains(e)
                                  ? null
                                  : MaterialStatePropertyAll(
                                      Color.fromARGB(255, 101, 213, 138)),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(
                height: ResponsiveHeight(context: context).scale(3),
              ),
              BlogEditor(
                  textcontroller: titlecontroller, hintText: 'Blog Title'),
              SizedBox(
                height: ResponsiveHeight(context: context).scale(3.5),
              ),
              BlogEditor(
                  textcontroller: contentcontroller, hintText: 'Blog content'),
            ],
          ),
        ),
      ),
    );
  }
}
