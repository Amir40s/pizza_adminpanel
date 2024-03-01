import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_adminpanel/utils/firebasepaths.dart';
import 'package:pizza_adminpanel/utils/loader/loader.dart';
import 'package:sizer/sizer.dart';

import 'add_product.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Products",style: TextStyle(fontSize: 18)),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Get.to( AddProduct(

              image1: "",
              categoryType : '',
              name: '',
              desc: '',
              price: '',

            ));
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
                                child: Text("Product Title",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)))),
                        Container(
                            color: Colors.amber,
                            padding: const EdgeInsets.all(10),
                            child: const Center(
                                child: Text("Product Price",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)))),
                        Container(
                            color: Colors.amber,
                            padding: const EdgeInsets.all(10),
                            child: const Center(
                                child: Text("Product desc",
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
                    stream: FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_PRODUCT).snapshots(),
                    builder: (context, snapShots) {
                      if (!snapShots.hasData) {
                        return const CircularProgressIndicator();
                      }
                      return ListView.builder(
                        itemCount: snapShots.data?.docs.length,
                        itemBuilder: (context, index) {
                          var products = snapShots.data?.docs[index].data() as Map<String,dynamic>;
        
                          return Table(
                            border: TableBorder.all(color: Colors.black, width: 2),
                            children: [
                              TableRow(
                                children: [
                                  Container(
                                      color: Colors.green,
                                      padding: const EdgeInsets.all(10),
                                      child:  Center(
                                          child: Image.network(products[FirebasePaths.KEY_PRODUCT_IMAGE],cacheHeight: 120,cacheWidth: 120,))),
                                  Container(
                                      color: Colors.amber,
                                      padding: const EdgeInsets.all(40),
                                      child:  Center(
                                          child: Text(products[FirebasePaths.KEY_PRODUCT_NAME],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18)))),
                                  Container(
                                      color: Colors.green,
                                      padding: const EdgeInsets.all(40),
                                      child:  Center(
                                          child: Text(products[FirebasePaths.KEY_PRODUCT_PRICE],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18)))),
                                  Container(
                                      color: Colors.green,
                                      padding: const EdgeInsets.all(40),
                                      child:  Center(
                                          child: Text(products[FirebasePaths.KEY_PRODUCT_DESC],
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
                                                        label: const Text("Product Name"),
                                                        border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10)
                                                        )
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 5,),
                                                Container(
                                                  width: 200,
                                                  height: 50,
                                                  color: Colors.white,
                                                  child: TextField(
                                                    controller: priceController,
                                                    decoration: InputDecoration(
                                                        label: const Text("Product Price"),
                                                        border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10)
                                                        )
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 5,),
                                                Container(
                                                  width: 200,
                                                  height: 50,
                                                  color: Colors.white,
                                                  child: TextField(
                                                    controller: descController,
                                                    decoration: InputDecoration(
                                                        label: const Text("Product desc"),
                                                        border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10)
                                                        )
                                                    ),
                                                  ),
                                                ),

                                                ElevatedButton(onPressed: (){
                                                  updateProduct(products[FirebasePaths.KEY_PRODUCT_ID]);
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
                                      deleteBrandName(products[FirebasePaths.KEY_PRODUCT_ID]);
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
    await FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_PRODUCT).doc(productId).update({
      FirebasePaths.KEY_PRODUCT_NAME : nameController.text.toString(),
      FirebasePaths.KEY_PRODUCT_DESC : descController.text.toString(),
      FirebasePaths.KEY_PRODUCT_PRICE : priceController.text.toString(),
    }
    ).whenComplete(() {
      Get.snackbar("Product Updated...","");
    });
  }
  void deleteBrandName(productID) async{
    await FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_PRODUCT).doc(productID).delete().whenComplete(() {
      Get.snackbar("Product Deleted...","");
    });
  }
}
