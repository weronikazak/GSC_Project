import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants.dart';
import 'package:gsc_project/Screens/User/shelter_info.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class Donate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference shelters =
        FirebaseFirestore.instance.collection('shelters');

    return StreamBuilder<QuerySnapshot>(
        stream: shelters.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                  child: Text(
                "Something went horribly wrong and we don't know what.",
                style: TextStyle(color: Colors.red),
              )),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                  child: Text("Loading",
                      style: TextStyle(
                          color: kPrimaryColor, fontSize: kmediumFontSize))),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text("HOMELESS CHARITIES"),
              ),
              backgroundColor: kPrimaryColor,
            ),
            body: ListView(
              children: snapshot.data.docs.map((DocumentSnapshot shelter) {
                return new Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black45,
                        ),
                        color: Colors.white10,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    padding: const EdgeInsets.all(20),
                    child: Row(children: <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 0, 20.0, 0),
                          child: Icon(
                            Icons.house,
                            color: kPrimaryColor,
                            size: 40.0,
                          )),
                      SizedBox(
                        width: 150,
                        child: Center(
                          child: Text(shelter.data()["name"],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 40.0),
                        child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  kPrimaryColor),
                              elevation: MaterialStateProperty.all(5.0),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShelterInfo(
                                          shelterId: shelter.id,
                                        )),
                              );
                            },
                            child: Text(
                              "More Info...",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ksmallFontSize),
                            )),
                      )
                    ]));
              }).toList(),
            ),
          );
        });
  }
}
