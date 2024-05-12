import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/core/common/widgets/loader.dart';
import 'package:fyp/core/common/widgets/reponsive.dart';
import 'package:fyp/core/utils/pick_image.dart';
import 'package:fyp/core/utils/show_snackbar.dart';
import 'package:fyp/features/DiseasePrediction/presentation/bloc/ml_bloc.dart';
import 'package:fyp/features/blog/presentation/pages/blog_page.dart';

class AlzhimerDetectionPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const AlzhimerDetectionPage(),
      );
  const AlzhimerDetectionPage({super.key});

  @override
  State<AlzhimerDetectionPage> createState() => _AlzhimerDetectionPageState();
}

class _AlzhimerDetectionPageState extends State<AlzhimerDetectionPage> {
  File? image;
  String label = '';
  double confidence = 0.0;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                if (image != null) {
                 context.read<MlBloc>().add(Mlpredict(image!));
                } else {
                  showSnackBar(context, 'Fields Can not be empty');
                }
              },
              icon: const Icon(Icons.done))
        ],
        title: Text('Alzhimer Detection'),
        leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context, BlogPage.route(), (route) => false);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body:
       BlocConsumer<MlBloc, MlState>(
        listener: (context, state) {
          if (state is Mlfailure) {
            showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is Mlloading) {
            return Loader();
          }
          if (state is Mlsucess) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    SizedBox(
                        width: double.infinity,
                        child: SingleChildScrollView(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      "The Disease is ${state.model.diseaseName}%",
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      "The Accuracy is ${state.model.confidence}%",
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          confidence = 0; // Reset confidence to 0
                          image = null;
                        });
                      },
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Center(
                          child: Text(
                            'Clear All',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return 
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  image != null
                      ? GestureDetector(
                          onTap: selectImage,
                          child: SizedBox(
                              width: double.infinity,
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
                          onTap: selectImage,
                          child: DottedBorder(
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
                  const SizedBox(
                    height: 30,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  image != null
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              confidence = 0; // Reset confidence to 0
                              image = null;
                            });
                          },
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Center(
                              child: Text(
                                'Clear Image',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          );
        }
        ,
      ),
    );
  }
}
