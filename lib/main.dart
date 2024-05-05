import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:fyp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fyp/features/auth/presentation/pages/signin_page.dart';
import 'package:fyp/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:fyp/features/blog/presentation/pages/blog_page.dart';
import 'package:fyp/features/init_dependencies.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initdependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => servicelocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (_) => servicelocator<AuthBloc>(),
      ),
    ],
    child: MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        home: BlocSelector<AppUserCubit, AppUserState, bool>(
          selector: (state) {
            return state is AppUserLoggedIn;
          },
          builder: (context, isLoggedIn) {
            if (isLoggedIn) {
              return SignInPage();
            } else
              return AddNewBlogPage();
          },
        ));
  }
}
