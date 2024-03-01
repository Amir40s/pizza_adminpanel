import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_adminpanel/banner/add_Banner.dart';

class BannerScreen extends StatefulWidget {
  const BannerScreen({super.key});

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  TextEditingController bannerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Banners'),),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Get.to(AddBanner());
      },
        backgroundColor: Colors.white,
      child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Table(
            border: TableBorder.all(color: Colors.black, width: 2),
            children: [
              TableRow(
                children: [
                  Container(
                      color: Colors.green,
                      padding: const EdgeInsets.all(10),
                      child: const Center(
                          child: Text("Logo",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)))),
                  Container(
                      color: Colors.amber,
                      padding: const EdgeInsets.all(10),
                      child: const Center(
                          child: Text("Banner Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)))),
                  Container(
                      color: Colors.green,
                      padding: const EdgeInsets.all(10),
                      child: const Center(
                          child: Text("Add",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)))),
                  Container(
                      color: Colors.blueGrey,
                      padding: const EdgeInsets.all(10),
                      child: const Center(
                          child: Text("Delete ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)))),
                ],
              ),

            ],
          ),
          SizedBox(
            height: size.height,
            width: size.width,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Banner').snapshots(),
              builder: (context,snapShots){
                return ListView.builder(
                    itemCount: snapShots.data?.docs.length,
                    itemBuilder: (context,index){
                      var myBanner = snapShots.data?.docs[index].data() as Map<String,dynamic>;

                      return Table(
                        border: TableBorder.all(color: Colors.black, width: 2),
                        children: [

                          TableRow(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(15),
                                  height: 35,
                                  width: 35,
                                  child: Image.network(myBanner['image1'].toString(),),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(15),

                                  child: Center(child: Center(child: Text(myBanner['name'].toString().toUpperCase(),style: const TextStyle(fontSize: 25)))),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(15),

                                  child: InkWell(onTap: (){
                                    bannerController.text = myBanner['name'];
                                    Get.bottomSheet(
                                        Column(
                                          children: [
                                            Container(
                                              width: Get.width,
                                              height: 300,
                                              color: Colors.white,
                                              child: TextField(
                                                controller: bannerController,
                                                decoration: InputDecoration(
                                                    label: const Text("banner Name"),
                                                    border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(10)
                                                    )
                                                ),
                                              ),
                                            ),

                                            ElevatedButton(onPressed: (){
                                              updateData(myBanner['id']);
                                            }, child: const Text("Update"))

                                          ],
                                        )
                                    );
                                  }, child: const Center(child: Text('Add',style: TextStyle(fontSize: 20,
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue

                                  ),))),

                                ),
                                Container(
                                  margin: const EdgeInsets.all(15),

                                  child: InkWell(onTap: (){
                                    deleteBrandName(myBanner['id']);
                                  }, child: const Center(child: Text('Delete',style: TextStyle(fontSize: 20,
                                      decoration: TextDecoration.underline,
                                      color: Colors.red
                                  ),))),
                                )
                              ]
                          ),
                        ],);
                    });

              },
            ),
          )

        ]),
      ),
    );
  }
  void deleteBrandName(brandID) {
    FirebaseFirestore.instance.collection('Banner').doc(brandID).delete().whenComplete(() {
      Get.snackbar("Banner Deleted...","");
    });
  }

  void updateData(brandID) async{

    await FirebaseFirestore.instance.collection('Banner').doc(brandID).update({
      'name':bannerController.text.toString()
    }
    ).whenComplete(() {
      Get.snackbar("Banner Updated...","");
    });
  }
}
