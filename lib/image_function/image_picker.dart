// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
// pickImage(ImageSource source) async{
//   final ImagePicker _immagePicker = ImagePicker();
//   XFile? _file = await _immagePicker.pickImage(source: source);
//   if(_file!= null){
//     return await _file.readAsBytes();
//   }
//   else{
//     Get.showSnackbar(GetSnackBar(title: "Error Occured",));
//   }
// }


import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../utils/firebasepaths.dart';
import '../utils/loader/loader.dart';

class imageController extends GetxController{
  Uint8List? pickedImage;
  Uint8List? pickedImage2;
  Uint8List? pickedImage3;
  var loading = false.obs;

  pickImageMethod(image) async {
    if(image == 1)
    {
      FilePickerResult? pickImage =
      await FilePicker.platform.pickFiles(type: FileType.image);
      if (pickImage == null) {
        return Get.showSnackbar(
            const GetSnackBar(
              title: 'Warning!',
              message: 'Please Select image!',
            )

        );
      } else {
        pickedImage = pickImage.files.first.bytes!;
        update();
      }
      update();
    }
    else  if(image == 2)
    {

      FilePickerResult? pickImage =
      await FilePicker.platform.pickFiles(type: FileType.image);
      if (pickImage == null) {
        return Get.showSnackbar(
            const GetSnackBar(
              title: 'Warning!',
              message: 'Please Select image!',
            )

        );
      } else {
        pickedImage2 = pickImage.files.first.bytes!;
        update();
      }
      update();
    }
    else  if(image == 3)
    {

      FilePickerResult? pickImage =
      await FilePicker.platform.pickFiles(type: FileType.image);
      if (pickImage == null) {
        return Get.showSnackbar(
            const GetSnackBar(
              title: 'Warning!',
              message: 'Please Select image!',
            )

        );
      } else {
        pickedImage3 = pickImage.files.first.bytes!;
        update();
      }
      update();
    }

  }


  uploadCategoryImage(categoryNameController,categoryOrderController) async {
    try {
      final String imageUrl = await firebaseStorageImage(image: pickedImage!);
      var id = FirebaseFirestore.instance.collection("Categories").doc().id.toString();
      await FirebaseFirestore.instance.collection("Categories").doc(id).set({
        'image': imageUrl,
        'id': id,
        'name': categoryNameController.toString().toLowerCase(),
        'displayType': categoryOrderController.toString().toLowerCase(),
      });
      Get.snackbar("Uploaded", "Successfully");
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  uploadBannerImage(bannerController) async {
    try {
      final String imageUrl = await firebaseStorageImage(image: pickedImage!);
      var id = FirebaseFirestore.instance.collection("Banner").doc().id.toString();
      await FirebaseFirestore.instance.collection("Banner").doc(id).set({
        'image': imageUrl,
        'id': id,
        'name': bannerController,
      });
      Get.snackbar("Uploaded", "Successfully");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  uploadProductImage(name,price,desc,type) async {
    try {
      final String imageUrl1 = await firebaseStorageImage(image: pickedImage!);
      var id = FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_PRODUCT).doc().id.toString();
      await FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_PRODUCT).doc(id).set({
        FirebasePaths.KEY_PRODUCT_IMAGE: imageUrl1,
        FirebasePaths.KEY_PRODUCT_ID: id,
        FirebasePaths.KEY_PRODUCT_NAME: name,
        FirebasePaths.KEY_PRODUCT_PRICE: price,
        FirebasePaths.KEY_PRODUCT_DESC: desc,
        'categoryType' : type.toString().toLowerCase(),

      }).whenComplete(() {
        EasyLoading.dismiss();
      });
      Get.snackbar("Uploaded", "Successfully");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  updateProductImage(name,price,desc,[productID]) async {
    try {
      final String imageUrl1 = await firebaseStorageImage(image: pickedImage!);
      await FirebaseFirestore.instance.collection("products").doc(productID).update({
        'image1': imageUrl1,
        'id': productID,
        'PizzaName': name,
        'PizzaPrice': price,
        'Pizza desc': desc,
      }).whenComplete(() {
        EasyLoading.dismiss();
      });
      Get.snackbar("Uploaded", "Successfully");
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  uploadMenuImage(name,type,displayType) async {
    try {
      final String imageUrl1 = await firebaseStorageImage(image: pickedImage!);
      var id = FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_MENU).doc().id.toString();
      await FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_MENU).doc(id).set({
        FirebasePaths.KEY_PRODUCT_IMAGE: imageUrl1,
        FirebasePaths.KEY_PRODUCT_ID: id,
        FirebasePaths.KEY_PRODUCT_NAME: name,
        'DisplayType' : displayType,
      }).whenComplete(() {
        EasyLoading.dismiss();
      });
      Get.snackbar("Menu Uploaded", "Successfully");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  firebaseStorageImage({required Uint8List image}) async {
    final Reference reference =
    FirebaseStorage.instance.ref('/BrandImage/${DateTime.now().toString()}');
    final UploadTask uploadTask = reference.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
  loader() async {
    loading.value = true;
    await Future.delayed(const Duration(seconds: 5));
    loading.value = false;
  }
}
