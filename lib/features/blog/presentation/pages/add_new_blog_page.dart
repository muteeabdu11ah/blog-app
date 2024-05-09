import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:fyp/core/common/widgets/loader.dart';
import 'package:fyp/core/common/widgets/reponsive.dart';
import 'package:fyp/core/utils/pick_image.dart';
import 'package:fyp/core/utils/show_snackbar.dart';
import 'package:fyp/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:fyp/features/blog/presentation/pages/blog_page.dart';
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
  final Formkey = GlobalKey<FormState>();

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
                if (Formkey.currentState!.validate() &&
                    selectedTopics.isNotEmpty &&
                    image != null) {
                  final userr =
                      (context.read<AppUserCubit>().state as AppUserLoggedIn)
                          .userData;
                  context.read<BlogBloc>().add(BlogUploadevent(
                      posterId: userr.id,
                      title: titlecontroller.text.trim(),
                      content: contentcontroller.text.trim(),
                      userName: userr.name,
                      topics: selectedTopics,
                      image: image!));
                } else {
                  showSnackBar(context, 'Fields Can not be empty');
                }
              },
              icon: const Icon(Icons.done))
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.error);
          } else if (state is BlogUploadSucess) {
            Navigator.pushAndRemoveUntil(
                context, BlogPage.route(), (route) => false);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return Loader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: ResponsiveHeight(context: context).scale(2),
                  horizontal: ResponsiveWidth(context: context).scale(3)),
              child: Form(
                key: Formkey,
                child: Column(
                  children: [
                    image != null
                        ? GestureDetector(
                            onTap: pickImage,
                            child: SizedBox(
                                width: double.infinity,
                                height: ResponsiveHeight(context: context)
                                    .scale(30),
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
                                  height: ResponsiveHeight(context: context)
                                      .scale(25),
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
                                    label: Text(
                                      e,
                                      style: TextStyle(
                                        color: selectedTopics.contains(e)
                                            ? Color.fromARGB(255, 255, 255, 255)
                                            : const Color.fromARGB(
                                                255, 56, 56, 56),
                                      ),
                                    ),
                                    color: !selectedTopics.contains(e)
                                        ? MaterialStatePropertyAll(
                                            Color.fromARGB(200, 211, 218, 220))
                                        : MaterialStatePropertyAll(Colors.blue),
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
                        textcontroller: titlecontroller,
                        hintText: 'Blog Title'),
                    SizedBox(
                      height: ResponsiveHeight(context: context).scale(3.5),
                    ),
                    BlogEditor(
                        textcontroller: contentcontroller,
                        hintText: 'Blog content'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
