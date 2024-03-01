import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sizer/sizer.dart';

import '../image_function/image_picker.dart';
import '../utils/loader/loader.dart';

class AddMenu extends StatefulWidget {
  String? image1,name,price,desc,categoryType;
  TextEditingController pizzaNameController = TextEditingController();
  TextEditingController displayTypeController = TextEditingController();
   AddMenu({super.key});

  @override
  State<AddMenu> createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {
  bool _image1click = false;
  String? categoryType = 'All';
  bool boxval1 = false;
  bool boxval2 = false;
  bool boxval3 = false;
  bool boxval4 = false;
  var pizzaSizes;


  @override
  Widget build(BuildContext context) {
    return GetBuilder<imageController>(
        init: imageController(),
        builder: (controller){
          return Scaffold(
            appBar: AppBar(
              title: Text('Add Menu'),
              centerTitle: true,
              backgroundColor: Colors.blue,
              elevation: 0,
            ),
            body: SingleChildScrollView(
                child: Column(
                  children: [
                    const Center(child: Text("Add Your Menu",style: TextStyle(fontSize: 25))),
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
                                        child: controller.pickedImage!=null && _image1click ==  true ? Image.memory(controller.pickedImage!) :
                                        _image1click == false && widget.image1 != "" ?  Image.network(widget.image1.toString())  :
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
                                            }, child: const Text("Upload image",style: TextStyle(color: Colors.white),)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],),],) ),
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
                                      label: const Text("Menu Type"),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      )
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 5),
                              child: SizedBox(
                                width: 40.w,
                                child: TextField(
                                  controller: widget.displayTypeController,
                                  decoration: InputDecoration(
                                      label: const Text("Display Type"),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      )
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Center(
                              child: Obx(() => controller.loading.value == false
                                  ? ElevatedButton(
                                  child: const Text('Upload Menu') ,
                                  onPressed: () {
                                    controller.uploadMenuImage(
                                      widget.pizzaNameController.text.toString(),
                                      categoryType.toString(),
                                      widget.displayTypeController.text.toString()
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
