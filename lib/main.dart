import 'package:flutter/material.dart';

import './models/Notes.dart';

import './widgets/notes_list.dart';
import './widgets/new_note.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.purpleAccent,
        accentColor: Colors.purpleAccent,
        brightness: Brightness.dark,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Notes> _userNotes = [];

  void _addNewNote(String title, String contents) {
    final newNote = Notes(
      title: title,
      contents: contents,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userNotes.add(newNote);
    });
  }

  void _deleteNote(String id) {
    setState(() {
      _userNotes.removeWhere((element) => element.id == id);
    });
  }

  void _startAddNewNote(BuildContext ctx, Notes modNote) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NotesLayout(
              addNotesHandler: _addNewNote,
              note: modNote,
            ),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      title: Text('Notes App'),
    );
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: (mediaQuery.size.height -
                    appBar.preferredSize.height -
                    mediaQuery.padding.top),
                child: NotesList(_userNotes, _deleteNote, _startAddNewNote),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewNote(context, null),
      ),
    );
  }
}
