import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takenotes/screens/noteEditor.dart';
import 'package:takenotes/screens/noteReader.dat.dart';
import 'package:takenotes/styles/appStyle.dart';
import 'package:takenotes/widgets/noteCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        elevation: 0,
        title: Text('Take Notes', style: TextStyle(fontSize: 24),),
        centerTitle: true,
        backgroundColor: AppStyle.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your recent Notes',
              style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("Notes").snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if(snapshot.hasData){
                    return GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2
                        ),
                      children: snapshot.data!.docs.map((note) => noteCard(() {
                        Navigator.push(
                            context, MaterialPageRoute(
                            builder: (context) => NoteReaderScreen(note),
                        ),
                        );
                      }, note)).toList(),
                    );
                  }
                  return Text("There is no Notes", style: GoogleFonts.nunito(color: Colors.white),);
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> NoteEditorScreen()));
          },
          label: Text('Add Notes'),
          icon: Icon(Icons.add),),
    );
  }
}
