import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool isHovered1 = false;
  bool isClicked1 = false;
  bool isHovered2 = false;
  bool isClicked2 = false;
  bool isHovered3 = false;
  bool isClicked3 = false;
  bool isHovered4 = false;
  bool isClicked4 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        backgroundColor: Colors.green,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
        child: SizedBox(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     InkWell(
              //       onHover: (true){
              //           setState(() {
              //             isHovered1 = true;
              //           });
              //
              //     },
              //       onTap: (){
              //         setState(() {
              //           isClicked1 = !isClicked1;
              //         });
              //       },
              //       child: MouseRegion(
              //         onEnter: (event) {mouseEnter(1,true);},
              //         onExit: (event) {mouseEnter(1,false);},
              //         child: Container(
              //           height: 100,
              //           width: 100,
              //           padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 8),
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(10),
              //             color: isClicked1 ? Colors.blue :
              //             (isHovered1 ? Colors.green : Colors.grey),
              //           ),
              //           child: Column(
              //             children: [
              //               Image.asset('assets/images/approved.png',height: 50),
              //               const Text("In Process",style: TextStyle(
              //                 fontWeight: FontWeight.bold,
              //                 fontSize: 18
              //               ),)
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //       child: GestureDetector(
              //         onTap: (){
              //           setState(() {
              //             isClicked2 = !isClicked2;
              //           });
              //         },
              //         child: MouseRegion(
              //           onEnter: (event){mouseEnter(2,true);},
              //           onExit: (event){mouseEnter(2,false);},
              //           child: Container(
              //             height: 100,
              //             width: 100,
              //             padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 8),
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(10),
              //               color: isClicked2?Colors.green:
              //               (isHovered2 ? Colors.amber : Colors.grey),
              //             ),
              //             child: Center(
              //               child: Column(
              //                 children: [
              //                   Image.asset('assets/images/preorder.png',height: 50),
              //                   const Text("Picked Up",style: TextStyle(
              //                     fontWeight: FontWeight.bold,
              //                     fontSize: 18,
              //                   ),)
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.symmetric( horizontal: 8.0),
              //       child: GestureDetector(
              //         onTap: (){},
              //         child: MouseRegion(
              //           onEnter: (event){mouseEnter(3,true);},
              //           onExit: (event){mouseEnter(3,false);},
              //           child: Container(
              //             height: 100,
              //             width: 100,
              //             padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 8),
              //             decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(10),
              //                 color: isHovered3 ?  Colors.green : Colors.grey
              //             ),
              //             child: Column(
              //               children: [
              //                 Image.asset('assets/images/cancel-order.png',height: 50),
              //                 const Text("Delivered",style: TextStyle(
              //                   fontWeight: FontWeight.bold,
              //                   fontSize: 18,
              //                 ),)
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //
              //     GestureDetector(
              //       onTap: (){},
              //       child: MouseRegion(
              //         onEnter: (event){mouseEnter(4,true);},
              //         onExit: (event){mouseEnter(4,false);},
              //         child: Container(
              //           height: 100,
              //           width: 100,
              //           padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 8),
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(10),
              //             color: isHovered4 ?  Colors.red : Colors.grey
              //           ),
              //           child: Column(
              //             children: [
              //               Image.asset('assets/images/cancel-order.png',height: 50),
              //               const Text("Reject",style: TextStyle(
              //                 fontWeight: FontWeight.bold,
              //                 fontSize: 18,
              //               ),)
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              Container(
                child: Column(
                  children: [
                    Visibility(
                        visible: isClicked1,
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                          ],
                        )),
                    Visibility(
                        visible: isHovered2,
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                          ],
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void mouseEnter(int containerNumber, bool hover) {
    setState(() {
      if (containerNumber == 1) {
        isHovered1 = hover;
      } else if (containerNumber == 2) {
        isHovered2 = hover;
      } else if (containerNumber == 3) {
        isHovered3 = hover;
      }else if (containerNumber == 4) {
        isHovered4 = hover;
      }
    });
  }

}

