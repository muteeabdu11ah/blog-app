import 'package:flutter/material.dart';

class ViewBlogPage extends StatelessWidget {
  final DateTime date;
  final String userName;
  final String title;
  final String Url;
  final List<String> tags;
  final String content;
  const ViewBlogPage(
      {super.key,
      required this.title,
      required this.Url,
      required this.tags,
      required this.content,
      required this.date,
      required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Blog'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                child: Row(
                  children: tags
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: () {},
                            child: Chip(
                              side: const BorderSide(
                                  color: Color.fromARGB(0, 0, 0, 0)),
                              label: Text(
                                e,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              color: const MaterialStatePropertyAll(
                                  Color.fromARGB(255, 1, 107, 212)),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    'Added By: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(userName)
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Date Added: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${date.day}-${date.month}-${date.year}')
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SingleChildScrollView(
                  child: Image.network(
                    Url,
                    fit: BoxFit.fitWidth,
                    height: 250,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Content:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                content,
                style: const TextStyle(color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
