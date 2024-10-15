//
// import 'package:flutter/material.dart';
//
//
// import '../Widget/widget.dart';
// import '../model/my_product.dart';
// import '../provider/product_favorite_card.dart';
// import 'details_screen.dart';
//
// class DisplayProductPage extends StatefulWidget {
//   const DisplayProductPage({super.key});
//
//   @override
//   State<DisplayProductPage> createState() => _DisplayProductPageState();
// }
//
// class _DisplayProductPageState extends State<DisplayProductPage> {
//   int isSelected = 0;
//
//   buildCategory(index, name) => GestureDetector(
//     onTap: () {
//       setState(() {
//         isSelected = index;
//       });
//     },
//     child: Container(
//       height: 40,
//       width: 100,
//       margin: const EdgeInsets.only(top: 10, right: 10),
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         color: isSelected == index ? Colors.green : Colors.green.shade300,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Text(
//         name,
//         style: const TextStyle(color: Colors.white),
//       ),
//     ),
//   );
//   buildAllBraids() => GridView.builder(
//
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           childAspectRatio: (100 / 140),
//           crossAxisSpacing: 12,
//           mainAxisSpacing: 12,
//           crossAxisCount: 2),
//       scrollDirection: Axis.vertical,
//       itemCount: MyProduct.allProducts.length,
//       shrinkWrap: true,
//       itemBuilder: (context, index) {
//         final allStyle = MyProduct.allProducts[index];
//         return GestureDetector(
//           //product description details
//           onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => DetailsPage(product: allStyle))),
//           child: ProductCard(
//             //for product details
//             products: allStyle,
//           ),
//         );
//       });
//   buildAfricanBraids() => GridView.builder(
//
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           childAspectRatio: (100 / 140),
//           crossAxisSpacing: 12,
//           mainAxisSpacing: 12,
//           crossAxisCount: 2),
//       scrollDirection: Axis.vertical,
//       itemCount: MyProduct.africaBraid.length,
//       shrinkWrap: true,
//       itemBuilder: (context, index) {
//         final africaStyle = MyProduct.africaBraid[index];
//         return GestureDetector(
//           onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => DetailsPage(product: africaStyle))),
//           child: ProductCard(
//             products: africaStyle,
//           ),
//         );
//       });
//   buildNigerianBraids() => GridView.builder(
//
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           childAspectRatio: (100 / 140),
//           crossAxisSpacing: 12,
//           mainAxisSpacing: 12,
//           crossAxisCount: 2),
//       scrollDirection: Axis.vertical,
//       itemCount: 6,
//       shrinkWrap: true,
//       itemBuilder: (context, index) {
//         final nigerianStyle = MyProduct.nigerianBraid[index];
//         return GestureDetector(
//           onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => DetailsPage(product: nigerianStyle))),
//           child: ProductCard(
//             products: nigerianStyle,
//           ),
//         );
//       });
//    buildSortAndFilterRow(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         Container(
//           width: MediaQuery.of(context).size.width/2,
//           decoration: BoxDecoration(
//             color: Colors.white,
//
//             shape: BoxShape.rectangle,
//             border: Border.all(
//                 width: 1,
//                 color: Colors.black26//
//             ),
//           ),
//           child: TextButton.icon(
//             icon: const Icon(Icons.sort),
//             label: const Text('Sort'),
//             onPressed: () {
//               // Handle sort button press
//             },
//           ),
//         ),
//
//         Container(
//           width: MediaQuery.of(context).size.width/2,
//           decoration: BoxDecoration(
//             color: Colors.white,
//
//             shape: BoxShape.rectangle,
//             border: Border.all(
//               width: 1,
//               color: Colors.black26//
//             ),
//           ),
//
//           child: TextButton.icon(
//
//             icon: const Icon(Icons.filter_list),
//             label: const Text('Filter'),
//             onPressed: () {
//               showFilterPopUp(context);
//             },
//           ),
//         ),
//       ],
//     );
//   }
//    showFilterPopUp(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Filter Options'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 CheckboxListTile(
//                   title: const Text('Option 1'),
//                   value: false,
//                   onChanged: (bool? value) {
//                     // Handle option 1
//                   },
//                 ),
//                 CheckboxListTile(
//                   title: const Text('Option 2'),
//                   value: false,
//                   onChanged: (bool? value) {
//                     // Handle option 2
//                   },
//                 ),
//                 // Add more options as needed
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: const Text('Apply'),
//               onPressed: () {
//                 // Handle apply filter
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body:    SizedBox(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           children: [
//             //const SizedBox(height: 30,),
//             Container(
//               height: 50,
//               //width: MediaQuery.of(context).size.width,
//               color: Colors.black,
//               child: const RowDrawerContent(),
//             ),
//             const SizedBox(height: 10,),
//             buildSortAndFilterRow(context),
//             const SizedBox(height: 10,),
//             // Container(
//             //   margin: const EdgeInsets.symmetric(vertical: 16.0),
//             //   height: 100,
//             //   color: Colors.white,
//             //   child: const CircularDrawerContent(),
//             // ),
//             // row drawer for circular all category
//
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   buildCategory(
//                     0,
//                     'All Braids',
//                   ),
//                   buildCategory(
//                     1,
//                     'African Braid',
//                   ),
//                   buildCategory(
//                     2,
//                     'Nigerian Braid',
//                   ),
//                   buildCategory(
//                     3,
//                     'Men',
//                   ),
//                   buildCategory(
//                     4,
//                     'Women',
//                   ),
//                   buildCategory(
//                     5,
//                     'Boys',
//
//                   ),
//                   buildCategory(
//                     6,
//                     'Girls',
//                   ),
//                   buildCategory(
//                     7,
//                     'Women',
//                   ),
//                   buildCategory(
//                     8,
//                     'Hajj & Umrah',
//                   ),
//                   buildCategory(
//                     9,
//                     'Saudi',
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//
//                 child: isSelected == 0
//
//                     ? buildAllBraids()
//                     : isSelected == 1
//                     ? buildAfricanBraids()
//                     : buildNigerianBraids()),
//
//           ],
//         ),
//     ));
//   }
// }

import 'package:flutter/material.dart';

import '../Widget/widget.dart';
import '../model/my_product.dart';
import '../provider/product_favorite_card.dart';
import 'details_screen.dart';

class DisplayProductPage extends StatefulWidget {
  const DisplayProductPage({super.key});

  @override
  State<DisplayProductPage> createState() => _DisplayProductPageState();
}

class _DisplayProductPageState extends State<DisplayProductPage> {
  final ValueNotifier<int> isSelected = ValueNotifier<int>(0);
  final List<String> categories = [
    'Mens', 'Women', 'Sports', 'Women', 'Boys', 'Girls', 'Brands', 'Sports','Arabia','Clearance'
  ];


  Widget buildCategory(int index, String name) {
    return GestureDetector(
      onTap: () {
        isSelected.value = index;
      },
      child: ValueListenableBuilder<int>(
        valueListenable: isSelected,
        builder: (context, selected, _) {
          return Container(
            height: 40,
            width: 100,
            margin: const EdgeInsets.only(top: 10, right: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected == index ? Colors.green : Colors.green.shade300,
              //borderRadius: BorderRadius.circular(8),
            ),
            child: Text(name, style: const TextStyle(color: Colors.white)),
          );
        },
      ),
    );
  }
     buildSortAndFilterRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: MediaQuery.of(context).size.width/2,
          decoration: BoxDecoration(
            color: Colors.white,

            shape: BoxShape.rectangle,
            border: Border.all(
                width: 1,
                color: Colors.black26//
            ),
          ),
          child: TextButton.icon(
            icon: const Icon(Icons.sort),
            label: const Text('Sort'),
            onPressed: () {
              // Handle sort button press
            },
          ),
        ),

        Container(
          width: MediaQuery.of(context).size.width/2,
          decoration: BoxDecoration(
            color: Colors.white,

            shape: BoxShape.rectangle,
            border: Border.all(
              width: 1,
              color: Colors.black26//
            ),
          ),

          child: TextButton.icon(

            icon: const Icon(Icons.filter_list),
            label: const Text('Filter'),
            onPressed: () {
              showFilterPopUp(context);
            },
          ),
        ),
      ],
    );
  }
   showFilterPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter Options'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                CheckboxListTile(
                  title: const Text('Option 1'),
                  value: false,
                  onChanged: (bool? value) {
                    // Handle option 1
                  },
                ),
                CheckboxListTile(
                  title: const Text('Option 2'),
                  value: false,
                  onChanged: (bool? value) {
                    // Handle option 2
                  },
                ),
                // Add more options as needed
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Apply'),
              onPressed: () {
                // Handle apply filter
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  buildAllBraids() => GridView.builder(

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: (100 / 140),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          crossAxisCount: 2),
      scrollDirection: Axis.vertical,
      itemCount: MyProduct.allProducts.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final allStyle = MyProduct.allProducts[index];
        return GestureDetector(
          //product description details
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailsPage(product: allStyle))),
          child: ProductCard(
            //for product details
            products: allStyle,
          ),
        );
      });
  buildAfricanBraids() => GridView.builder(

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: (100 / 140),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          crossAxisCount: 2),
      scrollDirection: Axis.vertical,
      itemCount: MyProduct.africaBraid.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final africaStyle = MyProduct.africaBraid[index];
        return GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailsPage(product: africaStyle))),
          child: ProductCard(
            products: africaStyle,
          ),
        );
      });
  buildNigerianBraids() => GridView.builder(

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: (100 / 140),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          crossAxisCount: 2),
      scrollDirection: Axis.vertical,
      itemCount: 6,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final nigerianStyle = MyProduct.nigerianBraid[index];
        return GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailsPage(product: nigerianStyle))),
          child: ProductCard(
            products: nigerianStyle,
          ),
        );
      });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(categories.length, (index) => buildCategory(index, categories[index])),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<int>(
                valueListenable: isSelected,
                builder: (context, selected, _) {
                  if (selected case 1) {
                    return buildAfricanBraids();
                  } else if (selected case 2) {
                    return buildNigerianBraids();
                  } else if (selected case 3) {
                    return buildNigerianBraids();
                  } else if (selected case 4) {
                    return buildNigerianBraids();
                  } else if (selected case 5) {
                    return buildNigerianBraids();
                  } else {
                    return buildAllBraids();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
