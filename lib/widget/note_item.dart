import 'package:flutter/material.dart';
import 'package:flutter_sqflite/model/notes.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({super.key, required this.note, required this.onNoteClick});

  final Note note;
  final void Function(Note note) onNoteClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onNoteClick(note);
      },
      child: Card(
        color: Colors.blue,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 10, bottom: 0, right: 0),
                child: Text(
                  note.title,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 0, left: 10, bottom: 10, right: 0),
                child: Text(
                  note.description,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
