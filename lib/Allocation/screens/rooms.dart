import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/initialize.dart';
import './entry.dart';

class Rooms extends StatefulWidget {
  @override
  _RoomsState createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Allocation System'),
          centerTitle: true,
      ),
      body: Center(
        child: DisplayData(),
      ),
    );
  }
}

class DisplayData extends StatefulWidget {
  @override
  _DisplayDataState createState() => _DisplayDataState();
}

class _DisplayDataState extends State<DisplayData> {
  
  @override
  Widget build(BuildContext context) {
    CollectionReference rooms = FirebaseFirestore.instance.collection(sportroomid);

    return StreamBuilder<QuerySnapshot>(
      stream: rooms.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(),
            );
        }

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return GestureDetector(
              onTap: () {
                selectedroomid = document.id;
                Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => Entry(),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
                color: Colors.blue[200],
                child: ListTile(
                  title: new Text(
                    document['roomname'], 
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white, 
                      fontWeight: FontWeight.bold
                      ),
                    ),
                ),
              ),
            );
          }).toList(),  
        );
      },
    );
  }
}

