import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/initialize.dart';

int micros = 1;

Future<List<int>> checkavailability(starttime, endtime) async{
  availability = [];
  CollectionReference equipments = FirebaseFirestore.instance.collection(sportequipmentid);

  //Adding microseconds to prevent isAfter from not working as intended
  var start = DateTime.parse(starttime);  
  start = start.add(new Duration(microseconds: micros));
  var end = DateTime.parse(endtime);
  end = end.add(new Duration(microseconds: micros));
  micros += 1;

  print("Time Slots: " + starttime + " to " + endtime);

  QuerySnapshot querySnapshot = await equipments.get();
  querySnapshot.docs.forEach((doc) {
    print("Checking for " + doc['name']);
    var bookedSlots = doc['bookedslots'];
    var n = doc['numberofbookedslots'];
    var currentquantity = doc['totalquantity'];

    for (int j = 0; j < n; j++) {
      if ((DateTime.parse(bookedSlots[j.toString()]['time']['0'])
                  .isAfter(start) &&
              DateTime.parse(bookedSlots[j.toString()]['time']['0'])
                  .isBefore(end)) ||
          (DateTime.parse(bookedSlots[j.toString()]['time']['1'])
                  .isAfter(start) &&
              DateTime.parse(bookedSlots[j.toString()]['time']['1'])
                  .isBefore(end))) {
        
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
