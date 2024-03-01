import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_adminpanel/utils/firebasepaths.dart';
import 'package:pizza_adminpanel/utils/loader/loader.dart';
import 'package:sizer/sizer.dart';

import 'add_Menu.dart';


class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController displayTypeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Menu",style: TextStyle(fontSize: 18)),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.to(()=> AddMenu());
        },
        child: const Icon(Icons.add),
      ),
      body:   SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            width: size.width,
            child: Column(

              children: [

                Table(
                  border: TableBorder.all(color: Colors.black, width: 2),
                  children: [
                    TableRow(
                      children: [
                        Container(
                            color: Colors.green,
                            padding: const EdgeInsets.all(10),
                            child: const Center(
                                child: Text("Image",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)))),
                        Container(
                            color: Colors.amber,
                            padding: const EdgeInsets.all(10),
                            child: const Center(
                                child: Text(" Title",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)))),
                        Container(
                            color: Colors.amber,
                            padding: const EdgeInsets.all(10),
                            child: const Center(
                                child: Text(" DisplayType",
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
                    )
                  ],
                ),
                SizedBox(
                  height: 85.h,
                  width: 100.w,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_MENU).snapshots(),
                    builder: (context, snapShots) {
                      if (!snapShots.hasData) {
                        return const CircularProgressIndicator();
                      }
                      return ListView.builder(
                        itemCount: snapShots.data?.docs.length,
                        itemBuilder: (context, index) {
                          var menu = snapShots.data?.docs[index].data() as Map<String,dynamic>;

                          return Table(
                            border: TableBorder.all(color: Colors.black, width: 2),
                            children: [
                              TableRow(
                                children: [
                                  Container(
                                      color: Colors.green,
                                      padding: const EdgeInsets.all(10),
                                      child:  Center(
                                          child: Image.network(menu[FirebasePaths.KEY_PRODUCT_IMAGE],cacheHeight: 120,cacheWidth: 120,))),
                                  Container(
                                      color: Colors.amber,
                                      padding: const EdgeInsets.all(40),
                                      child:  Center(
                                          child: Text(menu[FirebasePaths.KEY_PRODUCT_NAME],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18)))),
                                  Container(
                                      color: Colors.amber,
                                      padding: const EdgeInsets.all(40),
                                      child:  Center(
                                          child: Text(menu[FirebasePaths.KEY_DISPLAY_TYPE],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18)))),
                                  Container(
                                    color: Colors.amber,
                                    padding: const EdgeInsets.all(40),
                                    child: InkWell(onTap: (){
                                      Get.bottomSheet(
                                          backgroundColor: Colors.white,
                                          SizedBox(
                                            height: Get.height/2,
                                            width: Get.width/2,
                                            child: Column(
                                              children: [
                                                const SizedBox(height: 5,),
                                                Container(
                                                  width: 200,
                                                  height: 50,
                                                  color: Colors.white,
                                                  child: TextField(
                                                    controller: nameController,
                                                    decoration: InputDecoration(
                                                        label: const Text(" Name"),
                                                        border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10)
                                                        )
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  width: 200,
                                                  height: 50,
                                                  color: Colors.white,
                                                  child: TextField(
                                                    controller: displayTypeController,
                                                    decoration: InputDecoration(
                                                        label: const Text("Display Type"),
                                                        border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10)
                                                        )
                                                    ),
                                                  ),
                                                ),

                                                ElevatedButton(onPressed: (){
                                                  updateProduct(menu[FirebasePaths.KEY_PRODUCT_ID]);
                                                }, child: const Text("Update"))

                                              ],
                                            ),
                                          )
                                      );

                                    },
                                        child: const Center(child: Text('Update',style: TextStyle(fontSize: 20,
                                            decoration: TextDecoration.underline,
                                            color: Colors.blue
                                        ),))),
                                  ),
                                  Container(
                                    color: Colors.amber,
                                    padding: const EdgeInsets.all(40),
                                    child: InkWell(onTap: (){
                                      deleteBrandName(menu[FirebasePaths.KEY_PRODUCT_ID]);
                                    }, child: const Center(child: Text('Delete',style: TextStyle(fontSize: 20,
                                        decoration: TextDecoration.underline,
                                        color: Colors.red
                                    ),))),
                                  )
                                ],
                              )
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),

              ],
            ),
          ),
        ]),
      ),

    );
  }
  Future<void> updateProduct(String productId) async {
    await FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_MENU).doc(productId).update({
      FirebasePaths.KEY_PRODUCT_NAME : nameController.text.toString(),
      FirebasePaths.KEY_PRODUCT_IMAGE : displayTypeController.text.toString(),
    }
    ).whenComplete(() {
      Get.snackbar("Menu Updated...","");
    });
  }
  void deleteBrandName(productID) async{
    await FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_MENU).doc(productID).delete().whenComplete(() {
      Get.snackbar("Menu Deleted...","");
    });
  }
}
