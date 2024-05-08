import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/core/common/widgets/loader.dart';
import 'package:fyp/core/common/widgets/text_from_widget.dart';
import 'package:fyp/core/utils/show_snackbar.dart';
import 'package:fyp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fyp/features/auth/presentation/pages/signup_page.dart';
import 'package:get/get.dart';

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
          if (state is AuthLoading) return Loader();
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: Image.asset('flutter_assets/assets/MEDWISE.png'),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFieldInput(
                        textEditingController: emailcontroller,
                        hintText: 'email',
                        textInputType: TextInputType.emailAddress),
                    SizedBox(
                      height: 30,
                    ),
                    TextFieldInput(
                      textEditingController: passworcontroller,
                      hintText: 'password',
                      textInputType: TextInputType.visiblePassword,
                      isPass: true,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      child: Container(
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
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
                    SizedBox(
                      height: 30,
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(() => SignUpPage());
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ))
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
