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
        if (routeName != '')
          {
            Navigator.pushNamed(context, routeName),
          } //IMAGE ADD KARO WITH Image.asset url and text is the title. description bhi add karo alag se.
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width,
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
                      height: MediaQuery.of(context).size.height / 4.87,
                      width: MediaQuery.of(context).size.width / 2.28,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2.057,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 18.7,
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
