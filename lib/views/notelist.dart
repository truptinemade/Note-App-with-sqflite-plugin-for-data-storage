//import 'package:Notes/inherited_widgets/note_inherited_widgets.dart';
import 'package:Notes/provider/note_provider.dart';
import 'package:Notes/views/note.dart';
import 'package:flutter/material.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body:
       FutureBuilder(
         
         future: NoteProvider.getNoteList(),
         builder: (context,snapshot){
           if (snapshot.connectionState==ConnectionState.done){
             final notes=snapshot.data;
           
         return
         ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Note(NoteMode.editing, notes[index])));
                setState(() {});
              },
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _NodeTitle(notes[index]['title']),
                        Container(
                          height: 5,
                        ),
                        _NodeText(notes[index]['text'])
                      ],
                    ),
                  )));
        },
        itemCount: notes.length,
      ) ;
           }
           return Center(child:CircularProgressIndicator() );
       })
       ,
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Note(NoteMode.adding, null)));
            setState(() {});
          },
          child: Icon(Icons.add)),
    );
  }
}

class _NodeTitle extends StatelessWidget {
  final String _title;
  _NodeTitle(this._title);
  @override
  Widget build(BuildContext context) {
    return (Text(
      _title,
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    ));
  }
}

class _NodeText extends StatelessWidget {
  final String _text;
  _NodeText(this._text);
  @override
  Widget build(BuildContext context) {
    return (Text(
      _text,
      style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ));
  }
}
