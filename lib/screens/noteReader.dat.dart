import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:takenotes/styles/appStyle.dart';

class NoteReaderScreen extends StatefulWidget {
  QueryDocumentSnapshot doc;
  NoteReaderScreen(this.doc,{Key? key}) : super(key: key);

  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  @override
  Widget build(BuildContext context) {
    int color_id = widget.doc['color_id'];
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.doc["note_title"],
              style: AppStyle.mainTitle,
            ),
            SizedBox(height: 4,),
            Text(
              widget.doc["creation_date"],
              style: AppStyle.dateStyle,
            ),
            SizedBox(height: 28,),
            Text(
              widget.doc["note_content"],
              style: AppStyle.mainContent,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
