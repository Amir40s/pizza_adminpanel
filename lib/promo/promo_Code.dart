import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/firebasepaths.dart';
import '../utils/loader/loader.dart';
import 'add_Promo.dart';

class PromoCode extends StatefulWidget {
  const PromoCode({super.key});

  @override
  State<PromoCode> createState() => _PromoCodeState();
}

class _PromoCodeState extends State<PromoCode> {
  TextEditingController promoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promo Code'),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.green,
            child: const Icon(Icons.add,color: Colors.black),
            onPressed: (){
              Get.to(const AddPromo());
            }),
      body:  SingleChildScrollView(
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
                            child: Text("Promo",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)))),
                    Container(
                        color: Colors.green,
                        padding: const EdgeInsets.all(10),
                        child: const Center(
                            child: Text("Update",
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
                stream: FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_PROMO).snapshots(),
                builder: (context,snapShots){
                  return ListView.builder(
                      itemCount: snapShots.data?.docs.length,
                      itemBuilder: (context,index){
                        var promo = snapShots.data?.docs[index].data() as Map<String,dynamic>;
        
                        return Table(
                          border: TableBorder.all(color: Colors.black, width: 2),
                          children: [
        
                            TableRow(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(15),
        
                                    child: Center(child: Center(child: Text(promo[FirebasePaths.KEY_PROMO_CODE].toString().toUpperCase(),style: const TextStyle(fontSize: 25)))),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(15),
        
                                    child: InkWell(onTap: (){
                                      promoController.text = promo[FirebasePaths.KEY_PROMO_CODE];
                                      Get.bottomSheet(
                                          Column(
                                            children: [
                                              Container(
                                                width: Get.width,
                                                height: 300,
                                                color: Colors.white,
                                                child: TextField(
                                                  controller: promoController,
                                                  decoration: InputDecoration(
                                                      label: const Text("promo Name"),
                                                      border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(10)
                                                      )
                                                  ),
                                                ),
                                              ),
        
                                              ElevatedButton(onPressed: (){
                                                updateData(promo[FirebasePaths.KEY_PROMO_ID]);
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
                                      deletePromoName(promo[FirebasePaths.KEY_PROMO_ID]);
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
        
        
          ],
        ),
      )
    );
  }
  void deletePromoName(promoID) {
    FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_PROMO).doc(promoID).delete().whenComplete(() {
      Get.snackbar("Promo Code Deleted...","");
    });
  }

  void updateData(promoID) async{

    await FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_PROMO).doc(promoID).update({
      FirebasePaths.KEY_PROMO_CODE : promoController.text.toString()
    }
    ).whenComplete(() {
      Get.snackbar("Promo Code Updated...","");
    });
  }
}
