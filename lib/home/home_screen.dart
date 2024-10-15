import 'package:ecommerce_app/Screens/details_screen.dart';
import 'package:ecommerce_app/Widget/widget.dart';
import 'package:ecommerce_app/model/my_product.dart';
import 'package:ecommerce_app/provider/product_favorite_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Screens/product_Screen.dart';
import '../Widget/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int isSelected = 0;
  final List<String> categories = [
    'All Braids', 'African Braid', 'Nigerian Braid', 'Men', 'Women', 'Boys', 'Girls', 'Women', 'Hajj & Umrah', 'Saudi'
  ];

  buildCategory(index, name) => GestureDetector(
        onTap: () {
          setState(() {
            isSelected = index;
          });
        },
        child: Container(
          height: 40,
          width: 100,
          margin: const EdgeInsets.only(top: 10, right: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected == index ? Colors.green : Colors.green.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            name,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
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
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          //color: kPrimaryColor,
          child: ListView(children: [
            Container(
              height: 50,
              //width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: const RowDrawerContent(),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: const Center(
                child: Text(
                  'Message from server for capturing customer attention',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
            Container(
              //padding: const EdgeInsets.all(2.0),
              color: Colors.teal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 14),
                      child: Text(
                        'message from server!',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('message from server'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            //image with kid men and women elevated button
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const DisplayProductPage()));
              },
              child: Stack(children: [
                const Image(
                  image: AssetImage('assets/images/saudi7.png'),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 40,
                      top: 20,
                      bottom: 20,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const DisplayProductPage()));
                      },
                      child: const Text(
                        'Kids',
                        style: TextStyle(
                          color: kAccentColor,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 100,
                  bottom: 0,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 40, top: 20, bottom: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        //navigate to shop
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const DisplayProductPage()));
                      },
                      child: const Text(
                        'Men',
                        style: TextStyle(
                          color: kAccentColor,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 200,
                  bottom: 0,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 40, top: 20, bottom: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const DisplayProductPage()));
                      },
                      child: const Text(
                        'Women',
                        style: TextStyle(
                          color: kAccentColor,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),

              ]),
            ),
            const SizedBox(
              height: 5,
            ),

            //for you
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'For You',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            // row drawer for circular all category

            Container(
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              height: 100,
              color: Colors.white,
              child: const CircularDrawerContent(),
            ),
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () {},
              child: Stack(
                children: [
                  const Image(
                    image: AssetImage('assets/images/saudi.png'),
                    height: 400,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Positioned(
                   right: 120,
                    left: 120,
                    bottom: 270,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Container(
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'SHOP BY',
                            style: TextStyle(
                              color: kAccentColor,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 110,
                    left: 110,
                    bottom: 130,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        height: 70,
                        width: 270,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'CATEGORY',
                            style: TextStyle(
                              color: kAccentColor,
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 10,
                    bottom: 0,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Text(
                        'change from server',
                        style: TextStyle(
                          color: kAccentColor,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to shop
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        ),
                        child: const Text(
                          'Shop Now',
                          style: TextStyle(
                            color: Colors.white,  // White text for contrast
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),
            //People also get
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),  // Adjusted vertical padding to avoid overflow
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: FittedBox(  // Added FittedBox to ensure text scales properly within the available space
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'PEOPLE ALSO GET THIS',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
            ),

            //category scroll
            const SizedBox(
              height: 180,
              child: CategoryDrawerContent(),
            ),
            Container(
              height: 90,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red.shade100),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const ScrollableTabview(),
            ),
            const SizedBox(
              height: 10,
            ),


            GestureDetector(
                onTap: () {},
                child:
                    const Image(image: AssetImage('assets/images/saudi1.png'))),
            const SizedBox(
              height: 20,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, // Space evenly
              children: [
                Expanded(
                  child: ImageItemWidget(
                    image: 'assets/images/abaya1.png',
                    text: 'Dubai Lady',
                    onTap: () {
                      // Action for Dubai Lady
                    },
                  ),
                ),
                const SizedBox(width: 15), // Spacing between items
                Expanded(
                  child: ImageItemWidget(
                    image: 'assets/images/abaya1.png',
                    text: 'Dubai ALdy',
                    onTap: () {
                      // Action for Dubai ALdy
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),
            ImageItemWidget(
              image: 'assets/images/abaya1.png',
              text: 'New in Sisters',
              onTap: () {
                // Action for New in Sisters
              },
            ),

         Text(
              'Our Products',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                shadows: [
                  Shadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: const Offset(1, 1),
                    blurRadius: 3,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),

            SingleChildScrollView(
              //navigate to category screen
              scrollDirection: Axis.horizontal,
              child: Row(

                children: List.generate(categories.length, (index) => buildCategory(index, categories[index])),
              ),
            ),

            const SizedBox(
              height: 30,
            ),
            //Bottom page
            Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                color: const Color(0xffF2EADD),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'EDITED',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54, // Softer text color
                  letterSpacing: 1.2,   // Slight spacing for better readability
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'MAXIMALIST HOME',
                style: TextStyle(
                  fontSize: 28,  // Larger font size for emphasis
                  fontWeight: FontWeight.bold,
                  color: Color(0xff333333), // Darker color for better contrast
                ),
              ),


              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Handle shop button tap
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 3, // Add subtle shadow for better depth
                ),
                child: const Text(
                  'Shop Now',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

                const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Text(
                    '*Next day delivery is subject to stock, courier availability and courier area. Order cut off times may vary. For full exceptions please refer to our terms & conditions.',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Text(
                    'AB+ unlimited costs £22.50 for a 12 month subscription. Exceptions apply. For more information please refer to the terms & conditions.',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                const SizedBox(height: 16),
                const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Divider(
                        color: Color(0xffF2EADD),
                        thickness: 1,
                        indent: 50,
                        endIndent: 50,
                      ),
                      SizedBox(height: 8),
                      Icon(
                        Icons.email,
                        size: 24,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Be In The Know',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center, // Ensure text is centered
                      ),
                    ],
                  ),
                ),

                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 8),
                      const Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Text(
                          'Want to keep updated with the latest news, including offers, promotions, sale and store events?',
                          textAlign: TextAlign.center,  // Center the text content
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Handle subscribe button press
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal, // Button color
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          textStyle: const TextStyle(fontSize: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Subscribe'),
                      ),
                      const SizedBox(height: 16),
                      RichText(
                        textAlign: TextAlign.center,  // Center the RichText content
                        text: TextSpan(
                          style: const TextStyle(color: Colors.black, fontSize: 14),
                          children: [
                            const TextSpan(text: 'See AB store\'s full '),
                            TextSpan(
                              text: 'Terms and Conditions',
                              style: const TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                // Handle terms and conditions link tap
                              },
                            ),
                            const TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Privacy Policy and Cookie Policy',
                              style: const TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                // Handle privacy policy link tap
                              },
                            ),
                            const TextSpan(text: ' to find out more.'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),

        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: const Color(0xffF2EADD),
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Follow Us On Social Media',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildSocialIcon(Icons.facebook, Colors.blue),
                        buildSocialIcon(FontAwesomeIcons.instagram, Colors.purple),
                        buildSocialIcon(FontAwesomeIcons.youtube, Colors.red),
                        buildSocialIcon(FontAwesomeIcons.tiktok, Colors.black),
                        buildSocialIcon(FontAwesomeIcons.pinterest, Colors.redAccent),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Divider(
                color: Color(0xffF2EADD),
                thickness: 1.5, // Thicker divider for a more defined look
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildActionButton(
                    icon: FontAwesomeIcons.user,
                    label: 'My Account',
                    onTap: () {
                      // Handle My Account tap
                    },
                  ),
                  buildActionButton(
                    icon: FontAwesomeIcons.store,
                    label: 'Store Locator',
                    onTap: () {
                      // Handle Store Locator tap
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Customer Service - 012345678912',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                '© 2024 AB stores Retail Ltd. All Rights Reserved.',
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),


              ],
            ),
          ]),
        ),
      ),
    ));
  }
}
