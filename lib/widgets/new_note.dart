import 'package:flutter/material.dart';

import '../models/Notes.dart';

class NotesLayout extends StatefulWidget {
  final Function addNotesHandler;
  final Notes note;
  NotesLayout({this.addNotesHandler, this.note});
  @override
  _NotesLayoutState createState() => _NotesLayoutState();
}

class _NotesLayoutState extends State<NotesLayout> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredContent = _contentController.text;

    if (enteredTitle.isEmpty || enteredContent.isEmpty) return;

    widget.addNotesHandler(
      enteredTitle,
      enteredContent,
    );
    Navigator.of(context).pop();
  }

  void _setDefaultText(Notes note) {
    if (note != null) {
      _titleController = TextEditingController(text: note.title);
      _contentController = TextEditingController(text: note.contents);
    }
  }

  @override
  Widget build(BuildContext context) {
    _setDefaultText(widget.note); /* for view/edit mode */
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
              enableInteractiveSelection: true,
              maxLength: 256,
              maxLengthEnforced: true,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Contents'),
              controller: _contentController,
              onSubmitted: (_) => _submitData(),
              enableInteractiveSelection: true,
              minLines: 1,
              maxLines: 4,
            ),
            IconButton(
              icon: Icon(Icons.check_rounded),
              onPressed: _submitData,
              color: Theme.of(context).primaryColor,
            )
            // RaisedButton(
            //   child: Icon(Icons.check_rounded),
            //   color: Theme.of(context).primaryColor,
            //   textColor: Theme.of(context).textTheme.button.color,
            //   onPressed: _submitData,
            // ),
          ],
        ),
      ),
    );
  }
}
