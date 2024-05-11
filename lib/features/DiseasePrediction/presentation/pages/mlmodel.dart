import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fyp/core/common/widgets/reponsive.dart';
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
  File? filePath;
  String label = '';
  double confidence = 0.0;

 
 

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alzhimer Detection'),
        leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context, BlogPage.route(), (route) => false);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              filePath != null
                  ? GestureDetector(
                      onTap: (){},
                      child: SizedBox(
                          width: double.infinity,
                          //    height: ResponsiveHeight(context: context).scale(30),
                          child: SingleChildScrollView(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                filePath!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                    )
                  : GestureDetector(
                      onTap: () {},
                      child: DottedBorder(
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
                height: 30,
              ),
              Text(
                'Mild Demented',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              filePath != null
                  ? Text(
                      "The Accuracy is ${confidence.toStringAsFixed(0)}%",
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    )
                  : Container(),
              const SizedBox(
                height: 30,
              ),
              filePath != null
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          confidence = 0; // Reset confidence to 0
                          filePath = null;
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
      ),
    );
  }
}
