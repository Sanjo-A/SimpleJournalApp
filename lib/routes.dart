import 'screens/home.dart';
import 'screens/new_entry.dart';
import 'screens/view_entry.dart';
import 'package:flutter/material.dart';

class Routes{
  var appRoutes = <String, WidgetBuilder>{
    NewEntry.routeName: (context) => NewEntry(),
    ViewEntry.routeName:(context) => ViewEntry(),
  };
}