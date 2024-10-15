import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../provider/cart_provider.dart';
import '../authentication/Auth.dart';

class CartDetailsPage extends StatefulWidget {
  const CartDetailsPage({super.key, required this.cartItems});
  final List<String> cartItems;

  @override
  State<CartDetailsPage> createState() => _CartDetailsPageState();
}

class _CartDetailsPageState extends State<CartDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);
    final finalCartList = provider.cart;

    buildProductQuantity(IconData icon, int index) {
      return GestureDetector(
        onTap: () {
          setState(() {
            if (icon == Icons.add) {
              provider.incrementQuantity(index);
            } else {
              provider.decrementQuantity(index);
            }
          });
        },
        child: Container(
          height: 30,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.green.shade100,
          ),
          child: Icon(
            icon,
            size: 20,
            color: Colors.red,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(


        title: const Text('My Cart'),
        centerTitle: true,
        automaticallyImplyLeading: true,

      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              ListView.builder(
                shrinkWrap: true, // Important to make ListView fit inside another ListView
                physics: const NeverScrollableScrollPhysics(), // Prevents this ListView from scrolling
                itemCount: finalCartList.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image(
                                width: 60,
                                height: 60,
                                image: AssetImage(finalCartList[index].image),
                              ),
                              const SizedBox(width: 16.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      finalCartList[index].name,
                                      style: GoogleFonts.lateef(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                        "Category: ${finalCartList[index].category}"),
                                    Text(
                                        "Qty: ${finalCartList[index].quantity.toString()}"),
                                    Text(
                                        finalCartList[index].quantity != 0
                                            ? 'In Stock'
                                            : 'Out of Stock',
                                        style: GoogleFonts.lateef(
                                            textStyle: const TextStyle(
                                                color: Colors.green,
                                                fontSize: 14))),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Text("£${finalCartList[index].price}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4.0),
                                  Text(
                                      finalCartList[index].quantity.toString()),
                                  const SizedBox(height: 8.0),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        finalCartList[index].quantity == 0;
                                        finalCartList.removeAt(index);
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    child: const Text("Delete"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 170),
                            child: Row(
                              children: [
                                buildProductQuantity(Icons.add, index),
                                Text(
                                  finalCartList[index].quantity.toString(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                buildProductQuantity(Icons.remove, index),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const Image(image: AssetImage('assets/images/card.png')),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Order Summary',
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ),
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  Text(
                    '\$${provider.getTotalPrice()}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${provider.getTotalQuantity().toString()} - Items',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Text(
                    provider.getTotalDiscountedPrice().toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Discounted Price',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Text(
                    provider.getTotalReducedPrice().toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Saving',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      textInputAction: TextInputAction.done,
                      keyboardAppearance: Brightness.dark,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Enter Promo Code",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.purple.withOpacity(0.2),
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('APPLY'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckoutScreenPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[300],
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    'CHECK OUT',
                    style: GoogleFonts.poppins(),
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
