import 'package:flutter/material.dart';

class HomeScreenItem extends StatelessWidget {
  final title;
  final url;
  final routeName;

  HomeScreenItem({
    this.title,
    this.routeName,
    this.url,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        if (routeName != 'None')
          {
            Navigator.pushNamed(context, routeName),
          }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        elevation: 5,
        margin: EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.asset(
                    url,
                    height: 300,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 10,
                  left: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    width: 250,
                    color: Colors.black54,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
