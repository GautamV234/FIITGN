import 'package:flutter/material.dart';

class HomeScreenItem extends StatelessWidget {
  final title;
  final url;
  final routeName;
  final description;

  HomeScreenItem({
    this.title,
    this.routeName,
    this.url,
    this.description,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        if (routeName != 'None')
          {
            Navigator.pushNamed(context, routeName),
          } //IMAGE ADD KARO WITH Image.asset url and text is the title. description bhi add karo alag se.
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        width: 210.0,
        child: Row(
          // alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Stack(
                children: <Widget>[
                  //    Hero(
                  //    tag: url,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      url,
                      height: 180.0,
                      width: 180.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 120,
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        description,
                        style: TextStyle(color: Colors.grey),
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
