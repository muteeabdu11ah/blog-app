import 'package:fyp/core/secrets/app_secrets.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


final servicelocator = GetIt.instance;

Future<void> initdependencies()async{
  final supabase = await Supabase.initialize(
      url: AppSecrets.url, anonKey: AppSecrets.anonKey);
  
} 