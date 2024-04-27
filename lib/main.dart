import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/core/secrets/app_secrets.dart';
import 'package:fyp/features/auth/data/datasources/auth_remote_data_sources.dart';
import 'package:fyp/features/auth/data/repositories/auth_repository_implementation.dart';
import 'package:fyp/features/auth/domain/usecases/user_sign_up.dart';
import 'package:fyp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fyp/features/auth/presentation/pages/signin_page.dart';
import 'package:fyp/features/init_dependencies.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initdependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => servicelocator<AuthBloc>(),
      ),
    ],
    child: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        home: SignInPage());
  }
}
