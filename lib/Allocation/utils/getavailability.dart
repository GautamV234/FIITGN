import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/initialize.dart';

Future<List<int>> checkavailability(starttime, endtime) async{
  availability = [];
  CollectionReference equipments = FirebaseFirestore.instance.collection(sportequipmentid);

  //Adding microseconds to prevent isAfter from not working as intended
  var start = DateTime.parse(starttime);  
  //start = start.add(new Duration(microseconds: micros));
  var end = DateTime.parse(endtime);
  //end = end.add(new Duration(microseconds: micros));
  int startint = start.millisecondsSinceEpoch;
  int endint = end.millisecondsSinceEpoch;

  print("Time Slots: " + starttime + " to " + endtime);

  QuerySnapshot querySnapshot = await equipments.get();
  querySnapshot.docs.forEach((doc) {
    print("Checking for " + doc['name']); 
    var bookedSlots = doc['bookedslots'];
    var n = doc['numberofbookedslots'];
    var currentquantity = doc['totalquantity'];

    for (int j = 0; j < n; j++) {
      int tmpstart = DateTime.parse(bookedSlots[j.toString()]['time']['0']).millisecondsSinceEpoch;
      int tmpend = DateTime.parse(bookedSlots[j.toString()]['time']['1']).millisecondsSinceEpoch;
      print(startint); //14:00
      print(endint); //14:30 
      print(tmpstart); //12:30
      print(tmpend); //14:35
      print("hey");
      if ((startint <= tmpstart && tmpstart < endint) || (startint < tmpend &&  tmpend <= endint)) {   
        print("heelo 1");   
        print(currentquantity);
        print(bookedSlots[j.toString()]['availability']);
        if (currentquantity > bookedSlots[j.toString()]['availability']) {
          currentquantity = bookedSlots[j.toString()]['availability'];
        }
      }
    }

    print("For the chosen time slot, the quantity available is - " + currentquantity.toString());
    print(" ");      
    availability.add(currentquantity);
  });
  return availability;
}