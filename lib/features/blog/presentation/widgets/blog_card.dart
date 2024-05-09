import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fyp/core/utils/calculate_reading_time.dart';
import 'package:fyp/features/blog/domain/entity/blog.dart';
import 'dart:math';

import 'package:fyp/features/blog/presentation/pages/view_blog_page.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  const BlogCard({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewBlogPage(
                    title: blog.title,
                    Url: blog.imageURL,
                    tags: blog.topics,
                    content: blog.content,
                    date: blog.updatedAt,
                    userName: blog.userName!)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromRGBO(
                      Random().nextInt(255),
                      Random().nextInt(255),
                      Random().nextInt(255),
                      Random().nextDouble(),
                    ).withOpacity(0.6),
                    Color.fromRGBO(
                      Random().nextInt(255),
                      Random().nextInt(255),
                      Random().nextInt(255),
                      Random().nextDouble(),
                    ).withOpacity(0.6),
                    // Colors.blue.withOpacity(0.6),
                    // Colors.green.withOpacity(0.6),
                    // Colors.purple.withOpacity(0.6),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: blog.topics
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Chip(
                                    side: BorderSide(
                                        color:
                                            const Color.fromARGB(0, 0, 0, 0)),
                                    label: Text(
                                      e,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    color: MaterialStatePropertyAll(
                                        Color.fromARGB(255, 1, 107, 212)),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        blog.title,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text('${calcultaReadingTime(blog.content)} min')
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
