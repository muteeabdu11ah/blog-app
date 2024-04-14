import 'package:flutter/material.dart';
import 'package:fyp/core/secrets/app_secrets.dart';
import 'package:fyp/features/auth/presentation/pages/signin_page.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 final supabase =  await Supabase.initialize(url: AppSecrets.url,anonKey: AppSecrets.anonKey);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      theme:ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: SignInPage()
      
    );
  }
}
