// import 'package:flutter/material.dart';
// import 'ProfilePicScreen.dart';
// import 'HomeScreen.dart';
// import '../Providers/storeReturnProvider.dart';
// import 'package:provider/provider.dart';

// class DetailsScreen extends StatefulWidget {
//   static const routeName = '\DetailsScreen';
//   @override
//   _DetailsScreenState createState() => _DetailsScreenState();
// }

// class _DetailsScreenState extends State<DetailsScreen> {
//   // final String name;
//   // final String age;
//   // final String height;
//   // final String weight;
//   // final String gender;
//   // final String
//   @override
//   String id = '0000';

//   Widget build(BuildContext context) {
//     final storeReturnProvider = Provider.of<StoreReturnProvider>(context);
//     return Scaffold(
//         // backgroundColor: Colors.blueGrey,
//         resizeToAvoidBottomInset: false,
//         body: SingleChildScrollView(
//           child: Container(
//               // height: MediaQuery.of(context).size.height,
//               width: MediaQuery.of(context).size.width,
//               child: Column(
//                 children: [
//                   SizedBox(height: 70.0),
//                   Center(
//                       child: Text("Edit Profile",
//                           style: TextStyle(
//                               fontSize: 36, fontWeight: FontWeight.bold))),
//                   //for 60px height from top(margin)
//                   SizedBox(height: 40.0),
//                   ProfilePic(id),
//                   SizedBox(height: 25.0),
//                   Container(
//                     padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
//                     child: Form(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           TextFormField(
//                             //Name field
//                             decoration: InputDecoration(
//                               //label text defines the label of the textbox
//                               labelText: 'Full Name :',
//                               labelStyle: TextStyle(
//                                   fontSize: 20,
//                                   color: Colors.orange,
//                                   fontWeight: FontWeight.bold),
//                               //gives hint to user to write what
//                               hintText: 'Enter your Full Name',
//                             ),
//                             initialValue: storeReturnProvider.getName(id),
//                             onChanged: (String value) async {
//                               storeReturnProvider.setName(id: id, name: value);
//                             },
//                           ),
//                           SizedBox(height: 12.0),
//                           TextFormField(
//                             //Age field
//                             decoration: InputDecoration(
//                               //label text defines the label of the textbox
//                               labelText: 'Age :',
//                               labelStyle: TextStyle(
//                                   fontSize: 20,
//                                   color: Colors.orange,
//                                   fontWeight: FontWeight.bold),
//                               //gives hint to user to write what
//                               hintText: 'Enter your Age',
//                             ),
//                             initialValue: storeReturnProvider.getAge(id),
//                             keyboardType: TextInputType.numberWithOptions(
//                                 decimal: true, signed: false),
//                             onChanged: (String value) async {
//                               storeReturnProvider.setAge(id: id, age: value);
//                             },
//                           ),
//                           SizedBox(height: 12.0),
//                           TextFormField(
//                             //Height field
//                             decoration: InputDecoration(
//                               //label text defines the label of the textbox
//                               labelText: 'Height (in cm)',
//                               labelStyle: TextStyle(
//                                   fontSize: 20,
//                                   color: Colors.orange,
//                                   fontWeight: FontWeight.bold),
//                               //gives hint to user to write what
//                               hintText: 'Enter your height in centimeters',
//                             ),
//                             initialValue: null,
//                             keyboardType: TextInputType.numberWithOptions(
//                                 decimal: true, signed: false),
//                             onChanged: (String value) async {
//                               //Can use onFieldSubmitted this function will be called when the tick is clicked(i.e. submitted by user)
//                               //But major drawback of that, if user migrates to other field without blue tick than this field will not be submitted
//                               storeReturnProvider.setHeight(
//                                   id: id, height: value);
//                             },
//                           ),
//                           SizedBox(height: 12.0),
//                           TextFormField(
//                             //Weight field
//                             decoration: InputDecoration(
//                               //label text defines the label of the textbox
//                               labelText: 'Weight (in kg)',
//                               labelStyle: TextStyle(
//                                   fontSize: 20,
//                                   color: Colors.orange,
//                                   fontWeight: FontWeight.bold),
//                               //gives hint to user to write what
//                               hintText: 'Enter your weight in kilograms',
//                             ),
//                             initialValue: storeReturnProvider.getWeight(id),
//                             keyboardType: TextInputType.numberWithOptions(
//                                 decimal: true, signed: false),
//                             onChanged: (String value) async {
//                               storeReturnProvider.setWeight(
//                                   id: id, weight: value);
//                             },
//                           ),
//                           SizedBox(height: 12.0),
//                           //dropdown box for gender
//                           Row(children: [
//                             Text("Gender :",
//                                 style: TextStyle(
//                                     fontSize: 20,
//                                     color: Colors.orange,
//                                     fontWeight: FontWeight.bold)),
//                             Padding(
//                               padding: EdgeInsets.only(right: 20),
//                             ),
//                             DropdownButton<String>(
//                               value: storeReturnProvider.getGender(id),
//                               icon: Icon(Icons.arrow_downward),
//                               iconSize: 20,
//                               elevation: 16,
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 16,
//                               ),
//                               underline: Container(
//                                 height: 2,
//                                 color: Colors.orangeAccent,
//                               ),
//                               onChanged: (String newValue) {
//                                 setState(() {
//                                   storeReturnProvider.setGender(
//                                       id: id, gender: newValue);
//                                 });
//                               },
//                               items: <String>[
//                                 'Select',
//                                 'Male',
//                                 'Female',
//                                 'Other'
//                               ].map<DropdownMenuItem<String>>((String value) {
//                                 return DropdownMenuItem<String>(
//                                   value: value,
//                                   child: Text(value),
//                                 );
//                               }).toList(),
//                             )
//                           ]),
//                           SizedBox(height: 12.0),
//                           //dropdown box for Diet

//                           Row(children: [
//                             Text("Dietary Preference :",
//                                 style: TextStyle(
//                                     fontSize: 20,
//                                     color: Colors.orange,
//                                     fontWeight: FontWeight.bold)),
//                             Padding(
//                               padding: EdgeInsets.only(right: 20),
//                             ),
//                             DropdownButton<String>(
//                               value: storeReturnProvider.getDiet(id),
//                               icon: Icon(Icons.arrow_downward),
//                               iconSize: 20,
//                               elevation: 16,
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 16,
//                               ),
//                               underline: Container(
//                                 height: 2,
//                                 color: Colors.orangeAccent,
//                               ),
//                               onChanged: (String newValue) {
//                                 setState(
//                                   () {
//                                     storeReturnProvider.setDiet(
//                                         id: id, diet: newValue);
//                                   },
//                                 );
//                               },
//                               items: <String>[
//                                 'Select',
//                                 'Vegetarian',
//                                 'Eggitarian',
//                                 'Non-Vegetarian'
//                               ].map<DropdownMenuItem<String>>(
//                                 (String value) {
//                                   return DropdownMenuItem<String>(
//                                     value: value,
//                                     child: Text(value),
//                                   );
//                                 },
//                               ).toList(),
//                             )
//                           ]),

//                           SizedBox(height: 12.0),
//                           RaisedButton(
//                             onPressed: () {
//                               storeReturnProvider.setUserInputBool(true);
//                               storeReturnProvider.saveDetails(id);
//                               Navigator.pushReplacementNamed(
//                                   context, HomeScreen.routeName);
//                             },
//                             color: Colors.lightGreenAccent,
//                             child: Text('Save'),
//                           )

//                           //dropdown box for Workout
//                           // Row(children: [
//                           //   Text("Type of Workout :",
//                           //       style: TextStyle(
//                           //           fontSize: 20,
//                           //           color: Colors.orange,
//                           //           fontWeight: FontWeight.bold)),
//                           //   Padding(
//                           //     padding: EdgeInsets.only(right: 20),
//                           //   ),
//                           //   DropdownButton<String>(
//                           //     value: getWorkout(id),
//                           //     icon: Icon(Icons.arrow_downward),
//                           //     iconSize: 20,
//                           //     elevation: 16,
//                           //     style: TextStyle(
//                           //       color: Colors.black,
//                           //       fontSize: 16,
//                           //     ),
//                           //     underline: Container(
//                           //       height: 2,
//                           //       color: Colors.orangeAccent,
//                           //     ),
//                           //     onChanged: (String newValue) {
//                           //       setState(() {
//                           //         setWorkout(id: id, workout: newValue);
//                           //       });
//                           //     },
//                           //     items: <String>[
//                           //       'Select',
//                           //       'Weight Loss',
//                           //       'Weight Gain',
//                           //       'Body Toning',
//                           //       'Tabata',
//                           //       'Strength Training'
//                           //     ].map<DropdownMenuItem<String>>((String value) {
//                           //       return DropdownMenuItem<String>(
//                           //         value: value,
//                           //         child: Text(value),
//                           //       );
//                           //     }).toList(),
//                           //   )
//                           // ]),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               )),
//         ));
//   }
// }
