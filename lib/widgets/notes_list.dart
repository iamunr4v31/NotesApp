import 'package:flutter/material.dart';
import '../models/Notes.dart';

class NotesList extends StatelessWidget {
  final List<Notes> notes;
  final Function deleteNote;
  final Function editOrViewNote;
  NotesList(this.notes, this.deleteNote, this.editOrViewNote);
  @override
  Widget build(BuildContext context) {
    return notes.isEmpty
        ? Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'No notes here yet. Add Notes',
                )
              ],
            ),
          )
        : ListView.builder(
            itemBuilder: (BuildContext ctx, int index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  title: Text(
                    notes[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  trailing: MediaQuery.of(context).size.width > 420
                      ? FlatButton.icon(
                          textColor: Theme.of(context).errorColor,
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                          onPressed: () => deleteNote(notes[index].id),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => deleteNote(notes[index].id),
                        ),
                  onTap: () {
                    editOrViewNote(context, notes[index]);
                    notes.removeAt(index);
                  },
                ),
              );
            },
            itemCount: notes.length,
          );
  }
}
