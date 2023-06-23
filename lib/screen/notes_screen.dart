import 'package:flutter/material.dart';
import 'package:flutter_sqflite/databases/sqlite_service.dart';
import 'package:flutter_sqflite/model/notes.dart';
import 'package:flutter_sqflite/screen/new_item_screen.dart';
import 'package:flutter_sqflite/widget/note_item.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  var _notesList = [];

  @override
  void initState() {
    super.initState();
    SqliteService.initializeDB().whenComplete(() {
      _refreshNotes();
    });
  }

  void _refreshNotes() async {
    final data = await SqliteService.getItems();
    setState(() {
      _notesList = data;
    });
  }

  void _onRemoveExpense(Note note) {
    SqliteService.deleteItem(note.id!);
    _refreshNotes();
  }

  void _newItem() {
    showDialog(
        context: context,
        builder: (ctx) {
          return NewItemScreen(
            onAddItem: _addNote,
            onEditItem: (Note note) {},
          );
        });
  }

  void _editItem(Note note) {
    showDialog(
        context: context,
        builder: (ctx) {
          return NewItemScreen(
            onAddItem: _addNote,
            note: note,
            onEditItem: (Note note) {
              _updateNote(note);
            },
          );
        });
  }

  void _addNote(Note expense) {
    SqliteService.createItem(expense);
    _refreshNotes();
  }

  void _updateNote(Note expense) {
    SqliteService.updateUser(expense);
    _refreshNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text("Notes"),
      ),
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        backgroundColor: Colors.blue,
        onPressed: () {
          _newItem();
        },
        // isExtended: true,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: _notesList.length,
        itemBuilder: (ctx, index) {
          return Dismissible(
            key: ValueKey(_notesList[index]),
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.75),
              margin: const EdgeInsets.all(10),
            ),
            onDismissed: (direction) => {
              _onRemoveExpense(_notesList[index]),
            },
            child: NoteItem(
              note: _notesList[index],
              onNoteClick: _editItem,
            ),
          );
        },
      ),
    );
  }
}
