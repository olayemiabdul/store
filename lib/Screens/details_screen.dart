import 'dart:async';


import 'package:ecommerce_app/provider/cart_favorite_details.dart';
import 'package:ecommerce_app/Widget/size.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/provider/cart_provider.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/my_product.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.product});
  final Product product;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int firstPage = 0;
  PageController controller = PageController();
  final product=MyProduct.allProducts;
  final formKey = GlobalKey<FormState>();
  String? selectedSize;
  bool  readMore = false;





  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (firstPage < 5) {
        firstPage++;
      } else {
        firstPage = 0;
      }
      controller.animateToPage(
        firstPage,
        duration: const Duration(milliseconds: 250),
        curve: Curves.bounceInOut,
      );
    });


  }
  @override
  Widget build(BuildContext context) {
    // use the first one if cartProvider listen function is created
    final provider = CartProvider.of(context);
    //  use the second one if cartProvider listen function is  not created
    //final provider = Provider.of<CartProvider>(context);



    Column buildColumn(BuildContext context) {
      return Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 400,
            child: PageView.builder(
                itemCount: 4,
                pageSnapping: true,
                controller: controller,
                onPageChanged: (page) {
                  setState(() {
                    firstPage = page;
                  });
                },
                itemBuilder: (context, position) {
                  //bool active = position == firstPage;
                  //return myContainer(product,position,);
                  return carouselContainer(context, position);
                }),
          ),
          const SizedBox(
            height: 3,
          ),
          Container(
            color: Colors.white,
            width: 100,
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: indicators(4, firstPage,),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Braid details'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView(

            children: [
              const SizedBox(
                height: 36,
              ),
              Expanded(child: buildColumn(context)),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     // Container(
              //     //   width: 200,
              //     //   height: 200,
              //     //   decoration: BoxDecoration(
              //     //     color: Colors.green.shade100,
              //     //     shape: BoxShape.circle,
              //     //   ),
              //     //   child: Image.asset(
              //     //     product.image,
              //     //     fit: BoxFit.cover,
              //     //   ),
              //     // ),
              //
              //   ],
              // ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 800,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.product.name.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$' '${widget.product.price}',
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Text(
                      widget.product.description,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    const Row(
                      children: [
                        Text(
                          'Available grade',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        SizesPage(
                          size: 'UK S',
                        ),
                        SizesPage(
                          size: 'UK M',
                        ),
                        SizesPage(
                          size: 'UK L',
                        ),
                        SizesPage(
                          size: 'UK XL',
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Text('Available Colors'),
                      ],
                    ),
                    const Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.blue,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.red,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.amber,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    RatingBar.builder(
                      initialRating: 4,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16),
                          ),
                          hint: const Text("Choose Size"),
                          value: selectedSize,
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.black, fontSize: 16),
                          validator: (value) => value == null ? 'Please select a size' : null,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedSize = newValue;
                            });
                          },
                          items: <String>['Small', 'Medium', 'Large']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        ),
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            // Handle add to bag
                            print('Item added to cart');
                            provider.toggleProduct(widget.product);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CartDetailsPage(cartItems: [],)));

                          }
                        },
                        child: Text('Add To Bag (£${widget.product.price.toStringAsFixed(2)})'),
                      ),

                    ),
                    const SizedBox(
                      height: 5,
                    ),

                     Align(
                        alignment: Alignment.bottomLeft,
                        child: Text("Description", style: GoogleFonts.adamina(

                        ),)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        children: [
                          SizedBox(

                            height: 90,

                            child: Text(
                              widget.product.description,
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(color: Colors.black, letterSpacing: .5),

                              ),
                              maxLines: readMore ? 10 : 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            padding: const EdgeInsets.all(6),
                            child: GestureDetector(
                              child: Text(
                                readMore ? "Read less" : "Read more",
                                style: const TextStyle(color: Colors.blue),
                              ),
                              onTap: () {
                                setState(() {
                                  readMore = !readMore;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Card(
                      child: ListTile(
                        onTap: (){},
                        tileColor: Colors.tealAccent,
                        title: Text('Reviews',style:GoogleFonts.lato(
                          textStyle: const TextStyle(color: Colors.black, letterSpacing: .5),),),
                        trailing: const Icon(Icons.rate_review),
                      ),
                    ),


                    Card(
                      child: ListTile(
                        onTap: (){},
                        tileColor: Colors.tealAccent,
                        title: Text('Share',style:GoogleFonts.lato(
                          textStyle: const TextStyle(color: Colors.black, letterSpacing: .5),),),
                        trailing: const Icon(FontAwesomeIcons.share),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        onTap: (){},
                        tileColor: Colors.tealAccent,
                        title: Text('You may also Like',style:GoogleFonts.lato(
                          textStyle: const TextStyle(color: Colors.black, letterSpacing: .5),),),
                        trailing: const Icon(FontAwesomeIcons.share),
                      ),
                    ),
                  ],

                ),
              ),

            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 10,
        decoration: const BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: Row(
          children: [
            Text(
              '\$' '${widget.product.price}',
              style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton.icon(
              onPressed: () {
                provider.toggleProduct(widget.product);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CartDetailsPage(cartItems: [],)));
              },
              label: const Text('Add to cart'),
              icon: const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }

  Container carouselContainer(BuildContext context, int position) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 700,
      decoration: BoxDecoration(
          image: DecorationImage(
            //opacity: 0.5,

            image: AssetImage(

              widget.product.carouselImage[position].toString(),
            ),
            fit: BoxFit.fill,
          )),
      // child:
      // Column(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.only(top: 10, left: 40),
      //       child: Align(
      //         alignment: Alignment.topLeft,
      //         child: RichText(
      //           text: const TextSpan(
      //             text: 'Welcome To',
      //             style: TextStyle(
      //                 fontFamily: 'Satisfy',
      //                 color: Colors.green,
      //                 fontSize: 20),
      //             children: <TextSpan>[
      //               TextSpan(
      //                 text: ' WhiteSnow',
      //                 style: TextStyle(
      //                     fontFamily: 'Satisfy',
      //                     color: Colors.green,
      //                     fontSize: 20),
      //               ),
      //               TextSpan(
      //                 text: ' \n      ',
      //                 style: TextStyle(
      //                     fontFamily: 'Satisfy',
      //                     color: Colors.white,
      //                     fontSize: 20),
      //               ),
      //               TextSpan(
      //                 text: ' Garden Care',
      //                 style: TextStyle(
      //                     fontFamily: 'Satisfy',
      //                     color: Colors.greenAccent,
      //                     fontSize: 20),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //     // const SizedBox(height: 1,),
      //     Padding(
      //       padding: const EdgeInsets.only(top: 1, left: 20),
      //       child: Align(
      //         alignment: Alignment.topLeft,
      //         child: RichText(
      //           text: const TextSpan(
      //             text: ' Professional',
      //             style: TextStyle(
      //                 fontFamily: 'ConcertOne',
      //                 color: Colors.black,
      //                 fontSize: 50),
      //             children: <TextSpan>[
      //               TextSpan(
      //                 text: '\n',
      //                 style: TextStyle(
      //                     fontFamily: 'ConcertOne',
      //                     color: Colors.black,
      //                     fontSize: 20),
      //               ),
      //               TextSpan(
      //                 text: ' Gardeners',
      //                 style: TextStyle(
      //                     fontFamily: 'ConcertOne',
      //                     color: Colors.black,
      //                     fontSize: 50),
      //               ),
      //               TextSpan(
      //                 text: '&',
      //                 style: TextStyle(
      //                     fontFamily: 'ConcertOne',
      //                     color: Colors.black,
      //                     fontSize: 50),
      //               ),
      //               TextSpan(
      //                 text: '\n',
      //                 style: TextStyle(
      //                     fontFamily: 'ConcertOne',
      //                     color: Colors.black,
      //                     fontSize: 20),
      //               ),
      //               TextSpan(
      //                 text: ' Landscapers',
      //                 style: TextStyle(
      //                     fontFamily: 'ConcertOne',
      //                     color: Colors.black,
      //                     fontSize: 50),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //     const SizedBox(
      //       height: 20,
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(top: 10, left: 40),
      //       child: Align(
      //         alignment: Alignment.topLeft,
      //         child: RichText(
      //           text: const TextSpan(
      //             text:
      //             "Planting dreams, cultivating growth. Your garden's story begins with us.",
      //             style: TextStyle(
      //               decorationThickness: 2,
      //               decoration: TextDecoration.none,
      //               color: Colors.black,
      //               fontSize: 16,
      //               fontStyle: FontStyle.italic,
      //             ),
      //             children: <TextSpan>[
      //               TextSpan(
      //                 text: '\n',
      //                 style: TextStyle(
      //                     fontFamily: 'ConcertOne',
      //                     color: Colors.black,
      //                     fontSize: 2),
      //               ),
      //               TextSpan(
      //                 text:
      //                 "In the garden of business success, every seed we plant is a client's dream blossoming.",
      //                 style: TextStyle(
      //                     color: Colors.black, fontSize: 16),
      //               ),
      //               TextSpan(
      //                 text: '\n',
      //                 style: TextStyle(
      //                     fontFamily: 'ConcertOne',
      //                     color: Colors.black,
      //                     fontSize: 20),
      //               ),
      //               TextSpan(
      //                 text:
      //                 "Rooted in passion, flourishing in excellence. Your garden, our expertise.",
      //                 style: TextStyle(fontSize: 16),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //     const SizedBox(
      //       height: 20,
      //     ),
      //     Row(
      //       children: [
      //         InkWell(
      //           onTap: () {},
      //           child: Padding(
      //             padding: const EdgeInsets.only(left: 40),
      //             child: Container(
      //               padding: const EdgeInsets.only(
      //                 left: 3,
      //               ),
      //               height: 40,
      //               width: 140,
      //               decoration: const BoxDecoration(
      //                 borderRadius: BorderRadius.only(
      //                     topLeft: Radius.circular(5),
      //                     topRight: Radius.circular(5),
      //                     bottomLeft: Radius.circular(5),
      //                     bottomRight: Radius.circular(5)),
      //                 color: Colors.green,
      //                 shape: BoxShape.rectangle,
      //               ),
      //               child: Padding(
      //                 padding:
      //                 const EdgeInsets.only(left: 5, top: 5),
      //                 child: RichText(
      //                   text: const TextSpan(
      //                     text: 'Who',
      //                     style: TextStyle(
      //                         fontFamily: 'ConcertOne',
      //                         color: Colors.white,
      //                         fontSize: 20),
      //                     children: <TextSpan>[
      //                       TextSpan(
      //                         text: ' We Are',
      //                         style: TextStyle(
      //                             fontFamily: 'ConcertOne',
      //                             color: Colors.white,
      //                             fontSize: 20),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //         const SizedBox(
      //           width: 20,
      //         ),
      //         InkWell(
      //           onTap: () {},
      //           child: Container(
      //             padding: const EdgeInsets.only(left: 3, top: 3),
      //             height: 40,
      //             width: 140,
      //             decoration: const BoxDecoration(
      //               borderRadius: BorderRadius.only(
      //                   topLeft: Radius.circular(5),
      //                   topRight: Radius.circular(5),
      //                   bottomLeft: Radius.circular(5),
      //                   bottomRight: Radius.circular(5)),
      //               color: Colors.deepOrange,
      //             ),
      //             child: Padding(
      //               padding: const EdgeInsets.only(
      //                 top: 5,
      //               ),
      //               child: RichText(
      //                 text: const TextSpan(
      //                   text: 'Get',
      //                   style: TextStyle(
      //                       fontFamily: 'ConcertOne',
      //                       color: Colors.white,
      //                       fontSize: 20),
      //                   children: <TextSpan>[
      //                     TextSpan(
      //                       text: ' Free Quote',
      //                       style: TextStyle(
      //                           fontFamily: 'ConcertOne',
      //                           color: Colors.white,
      //                           fontSize: 20),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //       ],
      //     )
      //
      //   ],
      // )
    );
  }
  List<Widget> indicators(imagesLength, currentIndex, ) {
    return List.generate(
      imagesLength,
          (index) => Container(
        margin: const EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.black26,
            shape: BoxShape.circle),
      ),
    );
  }

}
