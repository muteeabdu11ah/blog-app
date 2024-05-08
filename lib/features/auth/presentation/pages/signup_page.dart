import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/core/common/widgets/loader.dart';
import 'package:fyp/core/common/widgets/text_from_widget.dart';
import 'package:fyp/core/utils/show_snackbar.dart';
import 'package:fyp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fyp/features/auth/presentation/pages/signin_page.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passworcontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();

  @override
  void dispose() {
    emailcontroller.dispose();
    passworcontroller.dispose();
    namecontroller.dispose();
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
          if (state is AuthLoading) {
            return const Loader();
          }
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: Image.asset('flutter_assets/assets/MEDWISE.png'),
                    ),
                    TextFieldInput(
                        textEditingController: namecontroller,
                        hintText: 'name',
                        textInputType: TextInputType.name),
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
                    TextButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(
                                AuthSignup(
                                  email: emailcontroller.text.trim(),
                                  name: namecontroller.text.trim(),
                                  password: passworcontroller.text.trim(),
                                ),
                              );
                        },
                        child: Text('Sign Up')),
                    TextButton(
                        onPressed: () {
                          Get.to(() => SignInPage());
                        },
                        child: Text('Sign In'))
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
