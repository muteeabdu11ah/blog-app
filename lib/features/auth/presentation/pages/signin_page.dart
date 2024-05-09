import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:fyp/core/common/widgets/loader.dart';
import 'package:fyp/core/common/widgets/text_from_widget.dart';
import 'package:fyp/core/utils/show_snackbar.dart';
import 'package:fyp/features/auth/domain/usecases/user_sign_up.dart';
import 'package:fyp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fyp/features/auth/presentation/pages/signup_page.dart';
import 'package:fyp/features/blog/presentation/pages/blog_page.dart';

class SignInPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => SignInPage(),
      );
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
          if (state is AuthLoading) return const Loader();
          if (state is AuthSucess) return const BlogPage();
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                    // gradient: LinearGradient(
                    //   begin: Alignment.centerLeft,
                    //   end: Alignment.centerRight,
                    //   colors: [Color(0xff662D8C), Color(0xffED1E79)],
                    // ),
                    ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.35,
                          child: Image.asset(
                            'flutter_assets/assets/MEDWISE.png',
                            color: const Color.fromARGB(255, 123, 192, 249),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              textAlign: TextAlign.right,
                              'Email',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        TextFieldInput(
                            textEditingController: emailcontroller,
                            hintText: 'Enter Your Email',
                            textInputType: TextInputType.emailAddress),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              textAlign: TextAlign.right,
                              'Password',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        TextFieldInput(
                          textEditingController: passworcontroller,
                          hintText: '*******',
                          textInputType: TextInputType.visiblePassword,
                          isPass: true,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        InkWell(
                          child: Container(
                            child: const Text(
                              'Log in',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: const ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                              color: Colors.blue,
                            ),
                          ),
                          onTap: () {
                            context.read<AuthBloc>().add(
                                  AuthLogIn(
                                    email: emailcontroller.text.trim(),
                                    password: passworcontroller.text.trim(),
                                  ),
                                );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'or',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.blue, // Blue border color
                              width: 1.0, // Border width
                            ),
                          ),
                          child: TextButton(
                              style: ButtonStyle(
                                  // side: MaterialStateProperty.all<BorderSide>(
                                  //   BorderSide(
                                  //       color: Colors.blue), // Blue border color
                                  // ),
                                  ),
                              onPressed: () {
                                Navigator.push(context, SignUpPage.route());
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 119, 119, 119)),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
