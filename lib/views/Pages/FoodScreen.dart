import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../foodrequest.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({Key? key}) : super(key: key);

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
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  //  Add your onPressed code here!
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Food_Request(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Icon(Icons.add),
                backgroundColor: Colors.green,
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
