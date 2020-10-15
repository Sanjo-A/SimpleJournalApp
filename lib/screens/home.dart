import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:journal/models/journal.dart';
import 'view_entry.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:journal/dbOperations.dart';



class VerticalHome extends StatefulWidget {
  static const routeName = '/';
  @override
  _VerticalHomeState createState() => _VerticalHomeState();
}

class _VerticalHomeState extends State<VerticalHome> {
  List<Map> allEntries;
  var journalEntries;
  Journal journal;

  @override
  void initState() {
    super.initState();
    setState(() {
      loadJournal();
    });
  }

  Future<List<Map>> loadJournal() async {
    final Database database = await openDatabase(
        'journal.db', version: 1, onCreate: (Database db, int version) async {
      await db.execute(createDb);
    }
    );
    allEntries = await database.rawQuery(getAllDb);
    journalEntries = allEntries.map((record) {
      return JournalEntry(
          title: record['title'],
          review: record['review'],
          rating: record['rating'],
          entryDate: record['entryDate']
      );
    }).toList();
    allEntries = journalEntries;
    return journalEntries;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadJournal(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (allEntries.isEmpty) {
              return Center(child: Container(
                  child: Text('Add a journal entry to begin!')));
            } else {
              return Container(
                  child: ListView(
                      children: allEntries.map((item) {
                        return ListTile(
                          leading: FlutterLogo(),
                          title: Text('${item['title']}'),
                          subtitle: Text('${item['entryDate']}'),
                          onTap: () =>
                              Navigator.of(context).pushNamed(ViewEntry
                                  .routeName, arguments: item),
                        );
                      }).toList()
                  )
              );
            }
          } else {
            return Container(child: Center(child: CircularProgressIndicator()));
          }
        });
  }
}
class HorizontalHome extends StatefulWidget {
  Map journalEntry ={};
  Function updateFunction;
  static const routeName = '/';
  HorizontalHome({@required this.journalEntry, this.updateFunction});

  @override
  _HorizontalHomeState createState() => _HorizontalHomeState();
}

class _HorizontalHomeState extends State<HorizontalHome> {
  List<Map> allEntries;
  var journalEntries;
  Journal journal;
  @override
  void initState() {
    super.initState();
    setState(() {
      loadJournal();
    });

  }
  Future<List<Map>> loadJournal() async {
    final Database database = await openDatabase(
        'journal.db', version: 1, onCreate: (Database db, int version) async {
      await db.execute(createDb);
    }
    );
    allEntries = await database.rawQuery(getAllDb);
    journalEntries = allEntries.map( (record){
      return JournalEntry(
          title: record['title'],
          review: record['review'],
          rating: record['rating'],
          entryDate: record['entryDate']
      );
    }).toList();
    allEntries = journalEntries;
    return journalEntries;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadJournal(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          if(allEntries.isEmpty){
            return Center(child: Container(child: Text('Add a journal entry to begin!')));
          }else{
            return Container(
                child: ListView(
                    children: allEntries.map((item){
                      return ListTile(
                          leading: FlutterLogo(),
                          title: Text('${item['title']}'),
                          subtitle: Text('${item['entryDate']}'),
                          onTap: () =>
                              setState((){
                                widget.journalEntry = item;
                                widget.updateFunction(item);
                              })
                      );
                    }).toList()
                )
            );
          }
          }else{
          return Container(child: Center(child: CircularProgressIndicator()));
        }

      },
    );
  }
  void check(Map item){
    print(item);
  }
}

