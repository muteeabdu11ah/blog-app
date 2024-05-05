import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/core/common/widgets/loader.dart';
import 'package:fyp/core/utils/show_snackbar.dart';
import 'package:fyp/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:fyp/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:fyp/features/blog/presentation/widgets/blog_card.dart';


class BlogPage extends StatefulWidget {
  static route()=> MaterialPageRoute(builder: (context)=>const BlogPage(),); 
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
    return  Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, AddNewBlogPage.route() );
            },
            icon: const Icon(Icons.add_rounded),
          )
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
if(state is BlogFailure){
  showSnackBar(context, state.error);
}        },
        builder: (context, state) {

          if(state is BlogLoading){
            return Loader();
          }
          if (state is BlogDisplaySucess){
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, item){
                final blog = state.blogs[item];
                return BlogCard(blog: blog);
              });
          }
          return SizedBox();
        },
      ),
    );
  }
}
