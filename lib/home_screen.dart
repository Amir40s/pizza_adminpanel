import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pizza_adminpanel/banner/banner.dart';
import 'package:pizza_adminpanel/category/add_categories.dart';
import 'package:pizza_adminpanel/menu/menu.dart';
import 'package:pizza_adminpanel/product/product.dart';
import 'package:pizza_adminpanel/promo/promo_Code.dart';
import 'package:pizza_adminpanel/users/users.dart';
import 'package:sizer/sizer.dart';

import 'category/categories.dart';
import 'order/order_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List colors = [Colors.amber,Colors.green,Colors.blue,Colors.red,Colors.pink,Colors.indigo,Colors.brown];
  List icons = [Icons.person,Icons.branding_watermark,Icons.production_quantity_limits,Icons.sell,Icons.picture_as_pdf,Icons.restaurant_menu,Icons.code_sharp];
  List text = ["Users","Categories","Products","Orders","Banners",'Menu','Promo'];
  List page = [const UserScreen(),const Categories(),const ProductScreen(),const OrderScreen(),const BannerScreen(),const MenuScreen(),const PromoCode()];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        title: const Text("Dashboard",style: TextStyle(fontSize: 45,color: Colors.black),),
        centerTitle: true,
      ),
      body: Column(
        children: [

          SizedBox(
            height: 600,
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                itemCount: text.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(

                      decoration: BoxDecoration(

                          color: colors[index],
                          borderRadius: BorderRadius.circular(18)
                      ),
                      height: 100,
                      width: 100,
                      child: InkWell(
                        onTap:(){
                         Get.to(page[index]);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(icons[index],color: Colors.white,size: 35),
                            Center(child: Text(text[index],style: const TextStyle(
                                color: Colors.white,fontSize: 25),)),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
