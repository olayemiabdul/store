import 'package:ecommerce_app/Screens/favourite_screen.dart';
import 'package:ecommerce_app/home/home_screen.dart';
import 'package:ecommerce_app/Screens/profile.dart';
import 'package:ecommerce_app/Widget/widget.dart';
import 'package:ecommerce_app/provider/cart_favorite_details.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ecommerce_app/address/deliveryCheckOut.dart';

import 'package:ecommerce_app/provider/cart_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isDrawerOpen = false;
  int currentIndex = 0;

  void openDrawer() {
    if (isDrawerOpen) {
      scaffoldKey.currentState!.openEndDrawer();
    } else {
      scaffoldKey.currentState!.openDrawer();
    }
    setState(() {
      isDrawerOpen = !isDrawerOpen;
    });
  }

  // Bottom navigation bar pages
  List<Widget> pages = [
    const HomeScreen(),
    const FavouriteScreen(),
    const UserProfileScreen(),
    const DeliveryPageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);

    return Scaffold(
      key: scaffoldKey,
      drawer: const DrawerPage(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,  // Subtle shadow for the app bar
        leading: Builder(
          builder: (context) {
            return SizedBox(
              height: 20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      isDrawerOpen ? FontAwesomeIcons.xmark : Icons.menu,
                      color: Colors.black,
                      size: 26.0,
                    ),
                    onPressed: openDrawer,
                  ),
                  const Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          },
        ),

        title: const Text(
          'AB STORE',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Search action
            },
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black),
            onPressed: () {
              // Profile action
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {
              // Favorites action
            },
          ),
          Stack(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.shopping_bag, color: Colors.black),
                onPressed: () {
                  if (provider.getTotalQuantity() == 0) {
                    // Display a snackbar if the cart is empty
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Your cart is empty!'),
                      ),
                    );
                  } else {
                    // Navigate to cart details
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const CartDetailsPage(cartItems: []),
                      ),
                    );
                  }
                },
              ),
              // Badge for cart items
              Positioned(
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    provider.getTotalQuantity().toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(FontAwesomeIcons.house, size: 24),
          ),
          BottomNavigationBarItem(
            label: 'Favourite',
            icon: Icon(FontAwesomeIcons.heart, size: 24),
          ),
          BottomNavigationBarItem(
            label: 'You',
            icon: Icon(FontAwesomeIcons.user, size: 24),
          ),
          BottomNavigationBarItem(
            label: 'Cart',
            icon: Icon(FontAwesomeIcons.bagShopping, size: 24),
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: pages[currentIndex],
      ),
    );
  }
}
