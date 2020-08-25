

//import 'package:Notes/inherited_widgets/note_inherited_widgets.dart';
import 'package:Notes/provider/note_provider.dart';
import 'package:flutter/material.dart';


enum NoteMode{
  editing,
  adding
}

class Note extends StatefulWidget {
 final NoteMode noteMode;
 //final int index;
  final Map<String,dynamic> note;
  Note(this.noteMode,this.note);

  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  final TextEditingController _titleController=TextEditingController();
  final TextEditingController _textController=TextEditingController();
 //List<Map<String,String>> get _notes => NoteInheritedWidget.of(context).notes;

 @override
  void didChangeDependencies() {
    
    if(widget.noteMode==NoteMode.editing)
    {
      _titleController.text=widget.note['title'];
    _textController.text=widget.note['text'];
    }
    super.didChangeDependencies();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.noteMode== NoteMode.adding ? 'Add Note' : 'Edit Note'  )),
        body: Padding(
            padding: EdgeInsets.all(40.0),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(hintText: 'Title'),
                ),
                Container(
                  height: 8.0,
                ),
                TextField(
                  controller: _textController,
                  decoration: InputDecoration(hintText: 'Text')),
                Container(height: 20.0),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _NoteButton('Save', Colors.blue, (){
                       final title = _titleController.text ;
                        final text =_textController.text;
                      if(widget?.noteMode == NoteMode.adding)
                      {
                       NoteProvider.insertNote({
                          'title' :title,
                          'text' :text
                        }
                        );
                        
                        
                        
                       } else if (widget?.noteMode==NoteMode.editing)
                        {
                          NoteProvider.updateNote(
                            {
                              'id': widget.note['id'],
                              'title':_titleController.text,
                              'text' : _textController.text
                        
                            }
                          );
                                       
                      }
                      Navigator.pop(context);
                       }),
                    _NoteButton('Discard', Colors.grey, (){Navigator.pop(context);}),
                    widget.noteMode==NoteMode.editing ? _NoteButton('Delete', Colors.red, () async {
                     // _notes.removeAt(widget.index);
                     await NoteProvider.deletNote({'id': widget.note['id'],
                              'title':_titleController.text,
                              'text' : _textController.text});
                     
                     print(widget.note['text']);
                      Navigator.pop(context);}):Container()
                       
                  ],
                )
              ],
            )));
  }
}
 
class _NoteButton extends StatelessWidget
{
  final String _text;
  final Color _color;
  final Function _onPressed;

  _NoteButton(this._text,this._color,this._onPressed);


  @override
  Widget build(BuildContext context) {
    return 
    MaterialButton(
                        onPressed: _onPressed,
                        child: Text(
                          _text,
                          style: TextStyle(color: Colors.white),
                        ),
                        minWidth: 100,
                        color: _color)
    ;
  }
} 