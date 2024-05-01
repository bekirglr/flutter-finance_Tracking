import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import '../services/firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Firestore
  final FirestoreSevice firestoreSevice = FirestoreSevice();

  //text controller
  final TextEditingController textController = TextEditingController();

  //open a dialog box to add a note
  void openNoteBox({String? docID}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textController,
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => {
                    //add a new note
                    if (docID == null)
                      {firestoreSevice.addNote(textController.text)}
                    //update an existing note
                    else
                      {firestoreSevice.updateNote(docID, textController.text)},

                    //clear the text controller
                    textController.clear(),

                    //close the box
                    Navigator.pop(context),
                  },
                  child: Text("Ekle"),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    String _text = "";
    return Scaffold(
        appBar: AppBar(
          title: Text(_text),
          centerTitle: true,
        ),
        floatingActionButton: SpeedDial(
          openBackgroundColor: Colors.green.shade200,
          labelsBackgroundColor: Colors.white,
          speedDialChildren: [
            SpeedDialChild(
              child: const Icon(FontAwesomeIcons.arrowTrendUp),
              foregroundColor: Colors.white,
              backgroundColor: Colors.green.shade500,
              label: 'Tutar Ekle',
              onPressed: () {},
            ),
            SpeedDialChild(
                child: const Icon(FontAwesomeIcons.arrowTrendDown),
                foregroundColor: Colors.white,
                backgroundColor: Colors.red.shade500,
                label: 'Tutar Çıkar',
                onPressed: () {}),
            SpeedDialChild(
              child: const Icon(FontAwesomeIcons.handHoldingDollar),
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue.shade500,
              label: 'Bakiye Oluştur',
              onPressed: () {},
            ),
          ],
          child: Icon(Icons.menu),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: firestoreSevice.getNoteStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List notesList = snapshot.data!.docs;
                return Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextField(
                        controller: textController,
                        textAlign: TextAlign.left,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: notesList.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot document = notesList[index];
                            String docID = document.id;
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            String noteText = data['note'];
                            return ListTile(
                                title: Text(noteText),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () =>
                                            openNoteBox(docID: docID),
                                        icon: Icon(Icons.settings)),
                                    IconButton(
                                        onPressed: () =>
                                            firestoreSevice.deleteNote(docID),
                                        icon: Icon(Icons.delete))
                                  ],
                                ));
                          }),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text("No data..."),
                );
              }
            }));
  }
}
