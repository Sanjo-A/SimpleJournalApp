import 'package:flutter/material.dart';
import 'package:journal/screens/new_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'themes.dart';
import 'routes.dart';
import 'screens/home.dart';
import 'screens/new_entry.dart';
import 'screens/view_entry.dart';

class JournalHome extends StatefulWidget  {
  final SharedPreferences sharedPreferences;

  JournalHome({Key key, @required this.sharedPreferences}) :super(key: key);
  @override
  _JournalHomeState createState() => _JournalHomeState();
}

class _JournalHomeState extends State<JournalHome> {
  Map journalEntry;
  bool darkMode;
  ThemeData theme;
  var routes = Routes().appRoutes;
  final appRoutes = {
    NewEntry.routeName: (context) => NewEntry(),
    ViewEntry.routeName:(context) => ViewEntry(),
  };
  bool get darkModeValue =>
      widget.sharedPreferences.getBool('darkMode') ?? false;

  void initState() {
    super.initState();
    if (darkModeValue) {
      theme = Themes().dark;
    }else{
      theme = Themes().light;
    }
  }

  void changeDarkMode(bool darkMode) {
    setState(() {
      darkMode = !darkModeValue;
      widget.sharedPreferences.setBool('darkMode', darkMode);
      print(darkMode);
      if (darkModeValue) {
        theme = Themes().dark;
      }else{
        theme = Themes().light;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Journal",
      theme: theme,
      routes: appRoutes,
      home: Builder(
          builder: (context) => Scaffold(
            appBar: AppBar(
                title: Text('Journal')),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text(
                      'Settings',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: GestureDetector(
                      child: Container(
                        child: Switch(
                            value: darkModeValue,
                            onChanged: changeDarkMode),
                      ),
                    ),
                    title: Text('Dark Mode'),
                  ),
                ],
              ),
            ),

            body: Container(
              child: LayoutBuilder(builder: (context, constraints){
                return constraints.maxWidth < 500 ? VerticalLayout() : HorizontalLayout();
              }),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => NewEntry()));
              })
            ),
          ),
        );
  }
  Widget layoutDecider(BuildContext context, BoxConstraints constraints, journalEntry) =>
      constraints.maxWidth < 500 ? VerticalLayout() : HorizontalLayout(journalEntry: journalEntry,);
}
class VerticalLayout extends StatefulWidget {
  @override
  _VerticalLayoutState createState() => _VerticalLayoutState();
}

class _VerticalLayoutState extends State<VerticalLayout> {
  @override
  Widget build(BuildContext context) {
    return VerticalHome();
  }
}
class HorizontalLayout extends StatefulWidget {
  Map journalEntry;
  @override
  HorizontalLayout({@required this.journalEntry});
  _HorizontalLayoutState createState() => _HorizontalLayoutState();
}

class _HorizontalLayoutState extends State<HorizontalLayout> {
  @override
  void updateEntry(journalEntry){
    setState(() {
      widget.journalEntry = journalEntry;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(child: HorizontalHome(journalEntry: widget.journalEntry, updateFunction: updateEntry)),
        Expanded(child: entryContent(widget.journalEntry))
      ],
    );
  }
}

