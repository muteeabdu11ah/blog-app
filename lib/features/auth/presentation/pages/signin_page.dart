import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/core/common/widgets/loader.dart';
import 'package:fyp/core/utils/show_snackbar.dart';
import 'package:fyp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fyp/features/auth/presentation/pages/signup_page.dart';
import 'package:get/get.dart';

class SignInPage extends StatefulWidget {
  SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passworcontroller = TextEditingController();

  @override
  void dispose() {
    emailcontroller.dispose();
    passworcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) return Loader();
          return SafeArea(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: 'email'),
                  controller: emailcontroller,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'password'),
                  controller: passworcontroller,
                ),
                TextButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            AuthLogIn(
                              email: emailcontroller.text.trim(),
                              password: passworcontroller.text.trim(),
                            ),
                          );
                    },
                    child: Text('Sign In')),
                TextButton(
                    onPressed: () {
                      Get.to(() => SignUpPage());
                    },
                    child: Text('Sign Up'))
              ],
            ),
          );
        },
      ),
    );
  }
}
