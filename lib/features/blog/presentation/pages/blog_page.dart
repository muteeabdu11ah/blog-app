import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/core/common/widgets/loader.dart';
import 'package:fyp/core/utils/show_snackbar.dart';
import 'package:fyp/features/DiseasePrediction/mlmodel.dart';
import 'package:fyp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fyp/features/auth/presentation/pages/signin_page.dart';
import 'package:fyp/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:fyp/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:fyp/features/blog/presentation/widgets/blog_card.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const BlogPage(),
      );
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(bloggetallblogsevent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Hi'),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(context,
                        AlzhimerDetectionPage.route(), (route) => false);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 59, 59, 59),
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(
                                2.0, 2.0), // shadow direction: bottom right
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.generating_tokens,
                            size: 40,
                            color: Colors.white,
                          ),
                          Text(
                            'Alzhimer Detection',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    context.read<AuthBloc>().add(AuthUserLogOut());
                    Navigator.pushAndRemoveUntil(
                        context, SignInPage.route(), (route) => false);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 49, 49, 49),
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(
                                2.0, 2.0), // shadow direction: bottom right
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.logout_sharp,
                            size: 40,
                            color: Colors.white,
                          ),
                          Text(
                            'LogOut',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, AddNewBlogPage.route());
            },
            icon: const Icon(Icons.add_rounded),
          )
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          if (state is BlogDisplaySucess) {
            return ListView.builder(
                itemCount: state.blogs.length,
                itemBuilder: (context, item) {
                  final blog = state.blogs[item];
                  return BlogCard(blog: blog);
                });
          }
          return const SizedBox();
        },
      ),
    );
  }
}
