import 'package:flutter/material.dart';
import 'package:flutter_sqflite/model/notes.dart';

class NewItemScreen extends StatefulWidget {
  const NewItemScreen(
      {super.key,
      required this.onAddItem,
      this.note,
      required this.onEditItem});

  final void Function(Note note) onAddItem;
  final void Function(Note note) onEditItem;
  final Note? note;

  @override
  State<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  late FocusNode _nodeTitle;
  late FocusNode _nodeDesc;
  late TextEditingController _titleController;
  late TextEditingController _descController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nodeTitle = FocusNode();
    _nodeDesc = FocusNode();
    if (widget.note == null) {
      _titleController = TextEditingController();
      _descController = TextEditingController();
    } else {
      _titleController = TextEditingController(text: widget.note!.title);
      _descController = TextEditingController(text: widget.note!.description);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _nodeDesc.dispose();
    _nodeTitle.dispose();
    super.dispose();
  }

  void _newItem() {
    widget.onAddItem(
        Note(title: _titleController.text, description: _descController.text));
    Navigator.pop(context);
  }

  void _editItem() {
    widget.onEditItem(Note(
        id: widget.note!.id,
        title: _titleController.text,
        description: _descController.text));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        widget.note == null ? 'New Item' : "Edit Item",
        textAlign: TextAlign.center,
      ),
      titleTextStyle: const TextStyle(
        fontSize: 20.0,
        color: Colors.blue,
        fontWeight: FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel'.toUpperCase(),
            style: const TextStyle(color: Colors.blue),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (widget.note == null) {
              _newItem();
            } else {
              _editItem();
            }
          },
          child: Text(
            'OK'.toUpperCase(),
            style: const TextStyle(color: Colors.blue),
          ),
        ),
      ],
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _titleController,
              focusNode: _nodeTitle,
              maxLength: 20,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              textInputAction: TextInputAction.next,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(_nodeDesc);
              },
            ),
            TextField(
              controller: _descController,
              focusNode: _nodeDesc,
              maxLength: 50,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              textInputAction: TextInputAction.next,
            ),
          ],
        ),
      ),
    );
  }
}
