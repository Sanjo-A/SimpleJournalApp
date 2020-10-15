import 'package:flutter/material.dart';

class ViewEntry extends StatefulWidget {
  static const routeName = 'ViewEntry';

  @override
  _ViewEntryState createState() => _ViewEntryState();
}

class _ViewEntryState extends State<ViewEntry> {
  Map entry;

  @override
  Widget build(BuildContext context) {
    final Map receivedVal = ModalRoute.of(context).settings.arguments;

    if (receivedVal == null) {
      return Scaffold(
        appBar: AppBar(
            title: Text('Journal Entry')),
        body: Container(
          child: Center(child: CircularProgressIndicator(),),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('${receivedVal['entryDate']}'),
        ),
        body: Center(
          child: entryContent(receivedVal)
        ),
      );
    }
  }

}

Widget entryContent(Map receivedVal){
  if(receivedVal == null ){
    return Column(
      children: [
        Text('Welcome!')
      ],
    );
  }else{
    return Column(
      children: [
        Text('${receivedVal['title']}', textScaleFactor: 2.0, textAlign: TextAlign.left,),
        Text('${receivedVal['review']}'),
        Text('Rating: ${receivedVal['rating']}')
      ],
    );
  }

}