import 'package:flutter/material.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:sqflite/sqflite.dart';
import 'package:journal/dbOperations.dart';
class NewEntry extends StatefulWidget {
  static const routeName = 'NewEntry';
  @override
  _NewEntryState createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  final formKey = GlobalKey<FormState>();
  final newJournalEntry = JournalEntry();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Title'),
                  validator: (String value){
                    if(value.isEmpty){
                      return 'A title is required';
                    }
                    return null;
                  },
                  onSaved: (value){
                    newJournalEntry.title = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Review'),
                  validator: (String value){
                    if(value.isEmpty){
                      return 'A Review is required';
                    }
                    return null;
                  },
                  onSaved: (value){
                    newJournalEntry.review = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Rating'),
                  validator: (String value){
                    if(value.isEmpty || double.tryParse(value) == null) {
                      return 'A rating is required';
                    }else if(double.tryParse(value) > 4 || double.tryParse(value) < 1){
                      return 'Choose a rating between 1 and 4';
                    }
                    return null;
                  },
                  onSaved: (value){
                    newJournalEntry.rating = value;
                  },
                ),
                Padding(
                    padding: EdgeInsets.all(30),
                    child: Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          RaisedButton(
                            child: Text('Cancel'),
                            onPressed: () =>
                              Navigator.of(context).pop(),
                          ),
                          Expanded(child: Container()),
                          RaisedButton(
                            child: Text('Submit'),
                            onPressed: () async {
                              if(formKey.currentState.validate()){
//                                DateTime entryDate = DateTime.now();
                                newJournalEntry.entryDate =  DateTime.now().toIso8601String();
//                                print(newEntry.entryDate);
                                formKey.currentState.save();
                                final Database database = await openDatabase(
                                  'journal.db', version: 1, onCreate: (Database db, int version) async {
                                    await db.execute(createDb);
                                  }
                                );
                                await database.transaction((txn) async{
                                  await txn.rawInsert(
                                      insertIntoDb,[newJournalEntry.title, newJournalEntry.review, newJournalEntry.rating, newJournalEntry.entryDate]);
                                });
                                await database.close();
//                                Navigator.pop(context);
                                Navigator.of(context).pushNamed('/');
                              }
                            }
                          )
                        ]
                    )
                )
              ],
            ),
          ),
        )
    );
  }
}

