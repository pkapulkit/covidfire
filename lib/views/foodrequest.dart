import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid/theme/routes.dart';
import 'package:covid/views/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Food_Request extends StatelessWidget {
  const Food_Request({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.homeRoute);
          },
        ),
        title: Text('Request Raised'),
      ),
      body: Food_RequestFul(),
    );
  }
}

class Food_RequestFul extends StatefulWidget {
  const Food_RequestFul({Key? key}) : super(key: key);

  @override
  _Food_RequestFulState createState() => _Food_RequestFulState();
}

class _Food_RequestFulState extends State<Food_RequestFul> {
  late TextEditingController name;
  late TextEditingController address;
  late TextEditingController mobile;
  late TextEditingController description;
  late User currentUser;
  late String uidh;
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  initState() {
    name = TextEditingController();
    address = TextEditingController();
    mobile = TextEditingController();
    description = TextEditingController();
    this.getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser!;
    //final FirebaseUser user = await auth.currentUser();
    //final uid = user.uid;
    uidh = currentUser.uid;
  }

  int _selected_value = 0;
  int identity = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              children: [
                Text(
                  'Note - App Team can call you to verify your details',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                Text(
                  'Note - On submit i have no concern related to the data used',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: ListTile(
                        title: const Text('Receiver'),
                        leading: Radio<int>(
                          value: 0,
                          groupValue: _selected_value,
                          onChanged: (value) {
                            setState(() {
                              identity = 0;
                              _selected_value = value!;
                            });
                          },
                        ),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('Donor'),
                        leading: Radio<int>(
                          value: 1,
                          groupValue: _selected_value,
                          onChanged: (value) {
                            setState(() {
                              identity = 1;
                              _selected_value = value!;
                            });
                          },
                        ),
                      ),
                      flex: 1,
                    ),
                    //     RadioListTile<int>(
                    //       value: 0,
                    //       groupValue: _selected_value,
                    //       title: Text('Reciever'),
                    //       onChanged: (value) => setState(() => _selected_value = 0),
                    //     ),
                    //     // new Text(
                    //     //   'Receiver',
                    //     //   style: new TextStyle(fontSize: 16.0),
                    //     // ),
                    //     new RadioListTile<int>(
                    //       value: 1,
                    //       groupValue: _selected_value,
                    //       title: Text('Donor'),
                    //       onChanged: (value) => setState(() => _selected_value = 1),
                    //     )
                    //     // new Text(
                    //     //   'Donor',
                    //     //   style: new TextStyle(
                    //     //     fontSize: 16.0,
                    //     //   ),
                    //     // ),
                  ],
                ),
                identity_user(),
                ElevatedButton(
                  onPressed: () {
                    if (name.text.isNotEmpty &&
                        address.text.isNotEmpty &&
                        identity == 0) {
                      FirebaseFirestore.instance
                          .collection("ReceiverFood")
                          .add({
                            "name": name.text,
                            "address": address.text,
                            "description": description.text,
                            "mobile": mobile.text,
                            "uid": uidh,
                          })
                          .then((result) => {
                                Navigator.pop(context),
                                name.clear(),
                                address.clear(),
                              })
                          .catchError((err) => print(err));

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return HomeScreen();
                          },
                        ),
                      );
                    } else {
                      FirebaseFirestore.instance
                          .collection("DonorFood")
                          .add({
                            "name": name.text,
                            "address": address.text,
                            "description": description.text,
                            "mobile": mobile.text,
                            "uid": uidh,
                          })
                          .then((result) => {
                                Navigator.pop(context),
                                name.clear(),
                                address.clear(),
                              })
                          .catchError((err) => print(err));

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return HomeScreen();
                          },
                        ),
                      );
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget identity_user() {
    if (identity == 0) {
      return Padding(
        padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 5),
        child: Column(
          children: <Widget>[
            SizedBox(height: 5),
            Container(
              height: 90,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(143, 148, 251, 1),
                  Color.fromRGBO(143, 148, 251, .6),
                ]),
              ),
              //R Name Box
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 10, bottom: 5),
                child: TextField(
                  controller: name,
                  textAlign: TextAlign.left,
                  onChanged: (val) => print(name.text),
                  maxLength: 20,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.blue.shade900,
                    fontFamily: 'SourceSansPro',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "  Full Name * ",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white60,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 90,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(143, 148, 251, 1),
                  Color.fromRGBO(143, 148, 251, .6),
                ]),
              ),
              // R address box
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 10, bottom: 5),
                child: TextField(
                  textAlign: TextAlign.left,
                  controller: address,
                  onChanged: (val) => print(address.text),
                  maxLength: 50,
                  // maxLines: null,
                  // keyboardType: TextInputType.multiline,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                    fontFamily: 'SourceSansPro',
                    fontSize: 25,
                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "   Address *",
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white60,
                        fontSize: 15,
                      )),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 90,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(143, 148, 251, 1),
                  Color.fromRGBO(143, 148, 251, .6),
                ]),
              ),
              //R mobile no
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 10, bottom: 5),
                child: TextField(
                  textAlign: TextAlign.left,
                  controller: mobile,
                  onChanged: (val) => print(mobile.text),
                  keyboardType: TextInputType.numberWithOptions(),
                  maxLength: 10,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                    fontFamily: 'SourceSansPro',
                    fontSize: 25,
                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "   Whatsapp Mobile Number *",
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white60,
                        fontSize: 15,
                      )),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 90,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(143, 148, 251, 1),
                  Color.fromRGBO(143, 148, 251, .6),
                ]),
              ),
              //R Description box
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 10, bottom: 5),
                child: TextField(
                  textAlign: TextAlign.left,
                  controller: description,
                  onChanged: (val) => print(description.text),
                  maxLength: 100,
                  // maxLines: null,
                  // keyboardType: TextInputType.multiline,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                    fontFamily: 'SourceSansPro',
                    fontSize: 25,
                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "   Description *",
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white60,
                        fontSize: 15,
                      )),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (identity == 1) {
      return Padding(
        padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 5),
        child: Column(
          children: <Widget>[
            SizedBox(height: 5),
            Container(
              height: 90,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(143, 148, 251, 1),
                  Color.fromRGBO(143, 148, 251, .6),
                ]),
              ),
              //D Name box
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 10, bottom: 5),
                child: TextField(
                  controller: name,
                  textAlign: TextAlign.left,
                  onChanged: (val) => print(name.text),
                  maxLength: 20,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.blue.shade900,
                    fontFamily: 'SourceSansPro',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "  Full Name * ",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white60,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 90,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(143, 148, 251, 1),
                  Color.fromRGBO(143, 148, 251, .6),
                ]),
              ),
              //D address box
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 10, bottom: 5),
                child: TextField(
                  textAlign: TextAlign.left,
                  controller: address,
                  onChanged: (val) => print(address.text),
                  maxLength: 50,
                  // maxLines: null,
                  // keyboardType: TextInputType.multiline,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                    fontFamily: 'SourceSansPro',
                    fontSize: 25,
                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "   Address *",
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white60,
                        fontSize: 15,
                      )),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 90,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(143, 148, 251, 1),
                  Color.fromRGBO(143, 148, 251, .6),
                ]),
              ),
              //D mobile no
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 10, bottom: 5),
                child: TextField(
                  textAlign: TextAlign.left,
                  controller: mobile,
                  onChanged: (val) => print(mobile.text),
                  keyboardType: TextInputType.numberWithOptions(),
                  maxLength: 10,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                    fontFamily: 'SourceSansPro',
                    fontSize: 25,
                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "   Whatsapp Mobile Number *",
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white60,
                        fontSize: 15,
                      )),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 90,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(143, 148, 251, 1),
                  Color.fromRGBO(143, 148, 251, .6),
                ]),
              ),
              //D Description box
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 10, bottom: 5),
                child: TextField(
                  textAlign: TextAlign.left,
                  controller: description,
                  onChanged: (val) => print(description.text),
                  maxLength: 100,
                  // maxLines: null,
                  // keyboardType: TextInputType.multiline,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                    fontFamily: 'SourceSansPro',
                    fontSize: 25,
                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "   Description *",
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white60,
                        fontSize: 15,
                      )),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Column(
        children: [
          Text('Select Above Role'),
        ],
      );
    }
  }
}
