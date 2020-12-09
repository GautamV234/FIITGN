import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../Providers/storeReturnProvider.dart';

class ProfilePic extends StatefulWidget {
  final id;
  ProfilePic(this.id);

  @override
  _ProfilePicState createState() => _ProfilePicState(id);
}

class _ProfilePicState extends State<ProfilePic> {
  final id;
  _ProfilePicState(this.id);
  File image;
  // this variable stores profile image, which will then be given to database based on user.
//executed when asked for camea image. ImageSource activates the source , in this case it is camera. in below case it is gallery.
//Below function uses a <Future> showModalBottomSheet to make a modal which appears at bottom to ask for options
//camera or gallery. It is similar to that when we click some file and mobile shows a modal asking which app
//to be used to open this file.
  void imageSelect(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          final storeReturnProvider = Provider.of<StoreReturnProvider>(context);
          _camera(var id) async {
            image = await ImagePicker.pickImage(
                source: ImageSource.camera, imageQuality: 50);

            setState(() {
              storeReturnProvider.setImage(id: id, img: image);
            });
          }

//this is executed when asked for pic from gallery.
          _gallery(var id) async {
            image = await ImagePicker.pickImage(
                source: ImageSource.gallery, imageQuality: 50);

            setState(() {
              storeReturnProvider.setImage(id: id, img: image);
            });
          }

          _remove(var id) async {
            setState(() {
              storeReturnProvider.setImage(id: id, img: null);
            });
          }

          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  //modal icons and respective functions called here
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Gallery'),
                      onTap: () {
                        _gallery(id);
                        //removes modal since we dont need it anymore( for now :))
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                      leading: new Icon(Icons.photo_camera),
                      title: new Text('Camera'),
                      onTap: () {
                        _camera(id);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                      leading: new Icon(Icons.remove_circle),
                      title: new Text('Remove Profile pic'),
                      onTap: () {
                        _remove(id);
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final storeReturnProvider = Provider.of<StoreReturnProvider>(context);
    return Center(
      //THis is the circular part of app that will contain the profile pic
      child: GestureDetector(
        onTap: () {
          //function executed when tapped on this region(GestureDetector)
          imageSelect(context);
        },
        child: CircleAvatar(
          radius: 70,
          backgroundColor: Colors.yellow[400],
          child: storeReturnProvider.getImage(id) != null
              ? ClipRRect(
                  //image!=null means there is a picture
                  borderRadius: BorderRadius.circular(60),
                  child: Image.file(
                    storeReturnProvider.getImage(id),
                    width: 120,
                    height: 120,
                    fit: BoxFit.fitHeight,
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(60)),
                  width: 100,
                  height: 100,
                  child: Icon(
                    Icons.add_photo_alternate,
                    color: Colors.grey[800],
                  ),
                ),
        ),
      ),
    );
  }
}
