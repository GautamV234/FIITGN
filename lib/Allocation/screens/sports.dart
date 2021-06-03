import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './roomorequipment.dart';
import '../data/initialize.dart';

class Sports extends StatefulWidget {
  static const routeName = "SportsScreen";

  @override
  _SportsState createState() => _SportsState();
}

class _SportsState extends State<Sports> {
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
    CollectionReference sports = FirebaseFirestore.instance.collection('Sports');

    return StreamBuilder<QuerySnapshot>(
      stream: sports.snapshots(),
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
              onTap: () async {
                String tempsportid = document['sportid'];
                int flag = await getData(tempsportid);
                if(flag == 1){
                  print(sportequipmentid);
                  print(sportroomid);
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => RoomOrEquipment(),
                    ),
                  );
                } else{
                  print("Error");
                }
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
                color: Colors.blue[200],
                child: ListTile(
                  title: new Text(
                    document['sportname'], 
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