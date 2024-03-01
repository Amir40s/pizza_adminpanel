import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../image_function/image_picker.dart';
import '../utils/loader/loader.dart';

class AddBanner extends StatefulWidget {
   AddBanner({super.key});

  @override
  State<AddBanner> createState() => _AddBannerState();
}

class _AddBannerState extends State<AddBanner> {
  TextEditingController bannerController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return GetBuilder<imageController>(
        init: imageController(),
        builder: (controller){
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.green,
                title: const Text("Banners",style: TextStyle(fontSize: 18)),
                centerTitle: true,
              ),
              body: Column(children: [
                const Center(child: Text("Add Your Banner type"),),
                Container(
                  height: 70,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                    ),
                  ),
                  child: controller.pickedImage!=null ? Image.memory(controller.pickedImage!):
                  const Center(child: Text("No Image Choosen")),
                ),
                SizedBox(height: 20,),
                Center(
                  child: ElevatedButton(
                      style:ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          fixedSize: const Size(150, 30)
                      ),
                      onPressed: () async{
                        await controller.pickImageMethod(1);
                      }, child: const Text("Upload",style: TextStyle(color: Colors.white),)),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 15),
                  child: Container(

                    width: 200,
                    child: TextField(
                      controller: bannerController,
                      maxLength: 20,
                      decoration: InputDecoration(
                          label: const Text("Banner "),
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
                        child: const Text('Upload Category') ,
                        onPressed: () {
                          controller.loader();
                          controller.uploadBannerImage(bannerController.text.toString());
                        })
                        : loader)
                ),
              ],)
          );
        });  }
}
