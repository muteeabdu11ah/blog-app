import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/core/utils/show_snackbar.dart';
import 'package:fyp/features/auth/presentation/bloc/auth_bloc.dart';

import '../../../../core/common/widgets/text_from_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => ForgotPasswordPage(),
      );

  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if(state is AuthFailure){
            showSnackBar(context, state.message);
          }
          if (state is AuthSent){
                 showSnackBar(context, state.message);

          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
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
                    const Row(
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
                    InkWell(
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          color: Colors.blue,
                        ),
                        child: const Text(
                          'Send Email',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () {
                        context.read<AuthBloc>().add(AuthUserForgotPassword(
                            email: emailcontroller.text));
                      },
                    ),
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
