import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sizer/sizer.dart';

import '../image_function/image_picker.dart';
import '../utils/loader/loader.dart';

class AddProduct extends StatefulWidget {
  String? image1,name,price,desc,categoryType;
  TextEditingController pizzaPriceController = TextEditingController();
  TextEditingController pizzaNameController = TextEditingController();
  TextEditingController pizzaSizeController = TextEditingController();
  TextEditingController pizzaDescriptionController = TextEditingController();

  AddProduct({super.key,
    required this.image1,
    required this.name,
    required this.price,
    required this.desc,
    required this.categoryType,
  });

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  bool _image1click = false;
  bool boxval1 = false;
  bool boxval2 = false;
  bool boxval3 = false;
  bool boxval4 = false;
  var pizzaSizes;
  String? categoryType = 'All';

  @override
  Widget build(BuildContext context) {
    return GetBuilder<imageController>(
        init: imageController(),
        builder: (controller){
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                const Center(child: Text("Add Your Product",style: TextStyle(fontSize: 25))),
               Row(children: [
                 Expanded(
                     flex: 2,
                     child: Column(children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           SizedBox(
                             width: 30.w,
                             child: Column(
                               children: [
                                 Container(
                                   height: 200,
                                   width: 350,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(15),
                                     border: Border.all(
                                         width: 2
                                     ),
                                   ),
                                   child: controller.pickedImage!=null
                                       && _image1click ==  true ?
                                   Image.memory(controller.pickedImage!) :
                                   _image1click == false && widget.image1 != "" ?
                                   Image.network(widget.image1.toString())  :
                                   const Center(child: Text("No image choose")),

                                 ),
                                 SizedBox(height: 0.95.h,),
                                 Center(
                                   child: ElevatedButton(
                                       style:ElevatedButton.styleFrom(
                                           backgroundColor: Colors.blue,
                                           fixedSize: const Size(150, 30)
                                       ),
                                       onPressed: (){
                                         setState(() {
                                           _image1click = true;
                                         });

                                         controller.pickImageMethod(1);
                                       }, child: const Text("Upload",style: TextStyle(color: Colors.white),)),
                                 ),
                               ],
                             ),
                           ),
                         ],),
                       const SizedBox(height: 15,),
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 18.0),
                         child: Column(
                           children: [
                             Text(
                               'Selected Value: $categoryType'.toString().toLowerCase(),
                               style: const TextStyle(fontSize: 20),
                             ),
                             Container(
                               height: 5.h,
                               padding: const EdgeInsets.all(10),
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 shape: BoxShape.rectangle,
                                 color: Colors.white,
                                 border: Border.all(),
                               ),
                               child: DropdownButton<String>(
                                 underline: Container(
                                   height: 0,
                                   color: Colors.transparent,
                                 ),
                                 value: categoryType,
                                 icon: const Icon(Icons.arrow_drop_down),
                                 iconSize: 16,
                                 style: const TextStyle(color: Colors.black),
                                 onChanged: (newValue) {
                                   setState(() {
                                     categoryType = newValue;
                                   });
                                 },
                                 items: <String>['All','Pizza', 'Burger', 'Fries', 'Drinks']
                                     .map<DropdownMenuItem<String>>((String value) {
                                   return DropdownMenuItem<String>(
                                     value: value,
                                     child: Text(value),
                                   );
                                 }).toList(),
                               ),

                             ),
                           ],
                         ),
                       ),
                     ],) ),
                 Expanded(
                     flex: 2,
                     child: Column(children: [
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 5),
                         child: SizedBox(
                           width: 40.w,
                           child: TextField(
                             controller: widget.pizzaNameController,
                             decoration: InputDecoration(
                                 label: const Text("Product Name"),
                                 border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(10)
                                 )
                             ),
                           ),
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 5),
                         child: SizedBox(
                           width: 40.w,
                           child: TextField(
                             controller: widget.pizzaPriceController,
                             decoration: InputDecoration(
                                 label: const Text("Product Price"),
                                 border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(10)
                                 )
                             ),
                           ),
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 18.0),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Checkbox(value: boxval1, onChanged: (value){
                               setState(() {
                                 boxval1 = value!;
                                 pizzaSizes = 'Small';
                               });
                             }),
                             const Text('Small',style: TextStyle(fontWeight: FontWeight.bold),),
                             Checkbox(value: boxval2, onChanged: (value){
                               setState(() {
                                 boxval2 = value!;
                                 pizzaSizes = 'Medium';
                               });
                             }),
                             const Text('Medium',style: TextStyle(fontWeight: FontWeight.bold),),
                             Checkbox(value: boxval3, onChanged: (value){
                               setState(() {
                                 boxval3 = value!;
                                 pizzaSizes = 'Large';
                               });
                             }),
                             const Text('Large',style: TextStyle(fontWeight: FontWeight.bold),),
                           ],),

                       ),
                       const SizedBox(height: 20,),
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 5),
                         child: SizedBox(
                           width: 40.w,
                           child: TextField(
                             maxLines: 2,
                             textAlign: TextAlign.start,
                             controller: widget.pizzaDescriptionController,
                             decoration: InputDecoration(
                                 label: const Text("Pizza Description"),
                                 border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(10)
                                 )
                             ),
                           ),
                         ),
                       ),
                       Center(
                         child: Obx(() => controller.loading.value == false
                             ? ElevatedButton(
                             child: const Text('Upload Product') ,
                             onPressed: () {
                               controller.uploadProductImage(
                                 widget.pizzaNameController.text.toString(),
                                 widget.pizzaPriceController.text.toString(),
                                 widget.pizzaDescriptionController.text.toString(),
                                 categoryType.toString(),
                               );
                             }
                         )
                             : loader),

                       ),
                     ],)),
               ],)



              ],)
            ),
          );
        });
  }

}
