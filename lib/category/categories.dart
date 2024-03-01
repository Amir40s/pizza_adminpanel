import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pizza_adminpanel/category/add_categories.dart';
import 'package:pizza_adminpanel/utils/firebasepaths.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Get.back();}, icon: const Icon(Icons.arrow_back)),
        backgroundColor: Colors.green,
        title: const Text("Categories",style: TextStyle(fontSize: 18)),
        centerTitle: true,),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
          child: const Icon(Icons.add,color: Colors.black),
          onPressed: (){
            Get.to(const AddCategories());
          }),
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
                          child: Text("category Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)))),
                  Container(
                      color: Colors.amber,
                      padding: const EdgeInsets.all(10),
                      child: const Center(
                          child: Text("category Type",
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
              stream: FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_CATEGORIES).snapshots(),
              builder: (context,snapShots){
                return ListView.builder(
                    itemCount: snapShots.data?.docs.length,
                    itemBuilder: (context,index){
                      var category = snapShots.data?.docs[index].data() as Map<String,dynamic>;

                      return Table(
                        border: TableBorder.all(color: Colors.black, width: 2),
                        children: [

                          TableRow(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(15),
                                  height: 35,
                                  width: 35,
                                  child: Image.network(category[FirebasePaths.KEY_PRODUCT_IMAGE].toString(),),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(15),

                                  child: Center(child: Center(child: Text(category[FirebasePaths.KEY_PRODUCT_NAME].toString().toUpperCase(),style: const TextStyle(fontSize: 25)))),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(15),

                                  child: Center(child: Center(child: Text(category['displayType'].toString().toUpperCase(),style: const TextStyle(fontSize: 25)))),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(15),

                                  child: InkWell(onTap: (){
                                    nameController.text = category[FirebasePaths.KEY_PRODUCT_NAME];
                                    Get.bottomSheet(
                                        Column(
                                          children: [
                                            Container(
                                              width: Get.width,
                                              height: 300,
                                              color: Colors.white,
                                              child: TextField(
                                                controller: nameController,
                                                decoration: InputDecoration(
                                                    label: const Text("category Name"),
                                                    border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(10)
                                                    )
                                                ),
                                              ),
                                            ),

                                            ElevatedButton(onPressed: (){
                                              updateData(category[FirebasePaths.KEY_PRODUCT_ID]);
                                            }, child: const Text("Update"))

                                          ],
                                        )
                                    );
                                  }, child: const Center(child: Text('UPDATE',style: TextStyle(fontSize: 20,
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue

                                  ),))),

                                ),
                                Container(
                                  margin: const EdgeInsets.all(15),

                                  child: InkWell(onTap: (){
                                    deleteBrandName(category[FirebasePaths.KEY_PRODUCT_ID]);
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
    FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_CATEGORIES).doc(brandID).delete().whenComplete(() {
      Get.snackbar("Category Deleted...","");
    });
  }

  void updateData(brandID) async{

    await FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_CATEGORIES).doc(brandID).update({
      FirebasePaths.KEY_PRODUCT_NAME : nameController.text.toString()
    }
    ).whenComplete(() {
      Get.snackbar("Category Updated...","");
    });
  }
}
