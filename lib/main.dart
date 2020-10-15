import 'package:flutter/material.dart';
import 'package:journal/journal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp
  ]);
  runApp(JournalHome(sharedPreferences: await SharedPreferences.getInstance()));
}
