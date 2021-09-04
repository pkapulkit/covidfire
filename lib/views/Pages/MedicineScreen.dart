import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//MyScreen
class MedicineScreen extends StatefulWidget {
  const MedicineScreen({Key? key}) : super(key: key);

  @override
  _MedicineScreenState createState() => _MedicineScreenState();
}

class _MedicineScreenState extends State<MedicineScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final tab = new TabBar(
      tabs: <Tab>[
        new Tab(
          text: 'Get help',
        ),
        new Tab(
          text: 'Give help',
        ),
      ],
    );
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: PreferredSize(
          preferredSize: tab.preferredSize,
          child: new Card(
            elevation: 26.0,
            color: Theme.of(context).primaryColor,
            child: tab,
          ),
        ),
        body: TabBarView(
          children: [
            Scaffold(
              backgroundColor: Colors.grey,
              body: Center(
                child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('ReceiverFood')
                          .where('uid', isEqualTo: user!.uid.toString())
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading");
                        }
                        return new ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            return Card(
                              color: Colors.white,
                              child: ListTile(
                                title: Text(data['name']),
                                subtitle: Text(data['address']),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    )),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.grey,
              body: Center(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('DonorFood')
                        .where('uid', isEqualTo: user!.uid.toString())
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }
                      return new ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          return Card(
                            color: Colors.white,
                            child: ListTile(
                              title: Text(data['name']),
                              subtitle: Text(data['address']),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
