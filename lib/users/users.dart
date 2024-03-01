import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Users",style: TextStyle(fontSize: 18)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Table(
              border: TableBorder.all(color: Colors.black, width: 1),
              children: [
                TableRow(
                  children: [
                    Checkbox(value: this.value, onChanged: (value){
                      this.value = value!;
                    }),
                    Container(
                        padding: const EdgeInsets.all(10),
                        child: const Center(
                            child: Text("Username",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)))),
                    Container(
                        padding: const EdgeInsets.all(10),
                        child: const Center(
                            child: Text("Email",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)))),
                    Container(
                        padding: const EdgeInsets.all(10),
                        child: const Center(
                            child: Text("Password",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)))),
                    Container(
                        padding: const EdgeInsets.all(10),
                        child: const Center(
                            child: Text("Delete ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)))),
                  ],
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              child: StreamBuilder<QuerySnapshot>(
                stream:
                FirebaseFirestore.instance.collection("Users").snapshots(),
                builder: (context, snapShot) {
                  return (snapShot.connectionState == ConnectionState.waiting)
                      ? const Center()
                      : ListView.builder(
                    itemCount: snapShot.data?.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapShot.data?.docs[index].data()
                      as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Table(
                          border: TableBorder.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          children: [
                            TableRow(children: [
                              Checkbox(value: this.value, onChanged: (value){
                                this.value = value!;
                              }),
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(data['name'].toString()),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data['email'].toString()),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data['password'].toString()),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(

                                    child: TextButton(
                                        onPressed: (){
                                          DeleteData(data['Userid']);
                                        },
                                        child: Text("Delete"))),
                              ),
                            ]),
                          ],
                        ),
                      );
                      //
                      // Container(
                      //   margin: EdgeInsets.all(10),
                      //   padding: EdgeInsets.all(10.0),
                      //   color: Colors.amber,
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text("Username: ${data['username']}"),
                      //       Text("Email: ${data['email']}"),
                      //       Text("Password: ${data['password']}"),
                      //     ],
                      //   ),
                      // );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  void DeleteData(userUID) async{

    await FirebaseFirestore.instance.collection("Users")
        .doc(userUID)
        .delete().whenComplete(() {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User Deleted")));
    });

  }
}