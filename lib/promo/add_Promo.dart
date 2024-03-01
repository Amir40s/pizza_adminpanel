import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_adminpanel/utils/firebasepaths.dart';

class AddPromo extends StatefulWidget {
  const AddPromo({super.key});

  @override
  State<AddPromo> createState() => _AddPromoState();
}

class _AddPromoState extends State<AddPromo> {
  TextEditingController promoController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Promo'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 70,
              width: 150,
              child: TextField(
                controller: promoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                hintText: 'Promo Code'
              ),
              ),
            ),
            Container(
              height: 70,
              width: 150,
              child: TextField(
                controller: discountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    hintText: 'Discount Price'
                ),
              ),
            ),
            Container(
              height: 50,
              width: 150,
              child: ElevatedButton(onPressed: (){
                uploadPromoCodeToFirebase();
              }, child: Text('Upload Code'))
            ),
          ],
        ),
      )
    );
  }

  void uploadPromoCodeToFirebase() {
    FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_PROMO)
        .doc(promoController.text.toString())
        .set({
      'promoCode' : promoController.text.toString(),
      'discountPrice': discountController.text.toString(),
    });

  }
}
