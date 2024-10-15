import 'package:ecommerce_app/Widget/appbar_widget_categories.dart';
import 'package:ecommerce_app/Widget/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/my_product.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // User Account Section (Optional)
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurpleAccent, Colors.pinkAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            accountName: Text(
              "Abdul A",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            accountEmail: Text("olayemiGgmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/card.png'),
            ),
          ),
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for products...',
                filled: true,
                fillColor: Colors.grey[200],
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const Divider(thickness: 1, color: Colors.grey),
          // List of Categories
          Expanded(
            child: ListView(
              children: [
                ExpansionTile(
                  leading: Image.asset('assets/images/clearance.png', width: 40, height: 40),
                  title: const Text(
                    'Fashion',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 28,
                    color: Colors.grey[600],
                  ),
                  children: [
                    drawerSubItem(
                      text: 'Footwear',
                      onTap: () {
                        // Handle tap on "Footwear"
                      },
                    ),
                    drawerSubItem(
                      text: 'Clothing',
                      onTap: () {
                        // Handle tap on "Clothing"
                      },
                    ),
                    drawerSubItem(
                      text: 'New In',
                      onTap: () {
                        // Handle tap on "New In"
                      },
                    ),
                    drawerSubItem(
                      text: 'Clearance',
                      color: Colors.redAccent,
                      onTap: () {
                        // Handle tap on "Clearance"
                      },
                    ),
                  ],
                ),
                drawerItem(
                  image: 'assets/images/men.png',
                  text: 'Men',
                  onTap: () {},
                ),
                drawerItem(
                  image: 'assets/images/women.png',
                  text: 'Women',
                  onTap: () {},
                ),
                drawerItem(
                  image: 'assets/images/boy.png',
                  text: 'Boys',
                  onTap: () {},
                ),
                drawerItem(
                  image: 'assets/images/girl.png',
                  text: 'Girls',
                  onTap: () {},
                ),
                drawerItem(
                  image: 'assets/images/footwears.png',
                  text: 'Footwear',
                  onTap: () {},
                ),
                drawerItem(
                  image: 'assets/images/holidays.png',
                  text: 'Holiday',
                  onTap: () {},
                ),
                drawerItem(
                  image: 'assets/images/school.png',
                  text: 'School',
                  onTap: () {},
                ),
                drawerItem(
                  image: 'assets/images/clearance.png',
                  text: 'Clearance',
                  color: Colors.redAccent,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget drawerItem({
    required String image,
    required String text,
    required GestureTapCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Image.asset(
        image,
        width: 40,
        height: 40,
        fit: BoxFit.contain,
      ),
      title: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: color ?? Colors.black87,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[600], size: 18),
      onTap: onTap,
    );
  }
  Widget drawerSubItem({
    required String text,
    required GestureTapCallback onTap,
    Color? color,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 72.0),  // Indent sub-items
      title: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: color ?? Colors.black87,
        ),
      ),
      onTap: onTap,
    );
  }

}

class RowDrawerContent extends StatelessWidget {
  const RowDrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            createDrawerItem(text: 'Women', onTap: () {}),
            createDrawerItem(text: 'Men', onTap: () { }),
            createDrawerItem(text: 'Boys', onTap: () {}),
            createDrawerItem(text: 'Girls', onTap: () {}),
            createDrawerItem(text: 'Home', onTap: () {}),
            createDrawerItem(text: 'Holiday', onTap: () {}),
            createDrawerItem(text: 'Shop', onTap: () {}),
            createDrawerItem(text: 'School', onTap: () {}),
            createDrawerItem(text: 'New in', onTap: () {}),
            createDrawerItem(text: 'baby', onTap: () {}),
            createDrawerItem(text: 'Brands', onTap: () {}),
            createDrawerItem(text: 'Sports', onTap: () {}),
          ],
        ),
      ),
    );
  }

  Widget createDrawerItem({required String text, required GestureTapCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.white,
            )
          )
        ),
      ),
    );
  }
  openWomenDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.9,

          child: Padding(
            padding: const EdgeInsets.only(top:60),
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.95, // 95% height
              // width: MediaQuery.of(context).size.width *0.95,
              decoration: const BoxDecoration(
                color: Colors.white,
                //borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              ),
              child: const WomenDrawer(),
            ),
          ),
        );
      },
    );
  }
  openMenDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.9, // Control how much of the screen the drawer occupies
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            ),
            child: const MenDrawer(),
          ),
        );
      },
    );
  }
  openGirlsDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.9, // Control how much of the screen the drawer occupies
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            ),
            child: const GirlsDrawer(),
          ),
        );
      },
    );
  }
  openBoysDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.9, // Control how much of the screen the drawer occupies
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            ),
            child: const BoysDrawer(),
          ),
        );
      },
    );
  }
  openHomeDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.9, // Control how much of the screen the drawer occupies
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            ),
            child: const HomeDrawer(),
          ),
        );
      },
    );
  }
  openHolidayDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.9, // Control how much of the screen the drawer occupies
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            ),
            child: const HolidayDrawer(),
          ),
        );
      },
    );
  }
  openShopDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.9, // Control how much of the screen the drawer occupies
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            ),
            child: const ShopDrawer(),
          ),
        );
      },
    );
  }
}

class CircularDrawerContent extends StatelessWidget {
  const CircularDrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          createDrawerItem(
            text: 'Womens',
            image: 'assets/womens.png',
            onTap: () {},
          ),
          createDrawerItem(
            text: 'Womens',
            image: 'assets/womens.png',
            onTap: () {},
          ),
          createDrawerItem(
            text: 'Womens',
            image: 'assets/womens.png',
            onTap: () {},
          ),
          createDrawerItem(
            text: 'Womens',
            image: 'assets/womens.png',
            onTap: () {},
          ),    createDrawerItem(
            text: 'Womens',
            image: 'assets/womens.png',
            onTap: () {},
          ),
          createDrawerItem(
            text: 'Mens',
            image: 'assets/mens.png',
            onTap: () {},
          ),
          createDrawerItem(
            text: 'Kids',
            image: 'assets/kids.png',
            onTap: () {},
          ),
          createDrawerItem(
            text: 'Home',
            image: 'assets/home.png',
            onTap: () {},
          ),
          createDrawerItem(
            text: 'Summer',
            image: 'assets/summer.png',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget createDrawerItem({required String text, required String image, required GestureTapCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            // CircleAvatar(
            //   backgroundImage: AssetImage(image),
            //   radius: 35,
            // ),
            Container(
              padding: const EdgeInsets.all(3),  // Space between image and border
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.red,  // Set the border color here
                  width: 2,  // Adjust the width of the border
                ),
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(image),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(text),
          ],
        ),
      ),
    );
  }
}

class CategoryDrawerContent extends StatelessWidget {
  const CategoryDrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    final products = MyProduct.allProducts;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        return createDrawerItem(
          text: products[index].name,
          image: products[index].image,
          onTap: () {},
          price: products[index].price.toString(),
          reducedPrice: products[index].reducedPrice.toString(),
        );
      },
    );
  }

  Widget createDrawerItem({
    required String text,
    required String reducedPrice,
    required String price,
    required String image,
    required GestureTapCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: Container(
          height: 180,
          width: 140,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  height: 90,
                  width: 120,
                  fit: BoxFit.cover,
                  image: AssetImage(image),
                ),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 4.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '£$price',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      '£$reducedPrice',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}










class ScrollableTabview extends StatefulWidget {
  const ScrollableTabview({super.key});

  @override
  _ScrollableTabviewState createState() => _ScrollableTabviewState();
}

class _ScrollableTabviewState extends State<ScrollableTabview> with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 8, vsync: this);
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop All'),
        centerTitle: true,
        backgroundColor: Colors.white,  // Changed to white for a cleaner UI
        elevation: 0,  // Removed shadow for a flat modern look
        titleTextStyle: const TextStyle(
          color: Colors.black,  // Set title color to black
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        iconTheme: const IconThemeData(color: Colors.black),  // Ensure icons are also black
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),  // Set height for bottom area
          child: TabBar(
            isScrollable: true,
            controller: tabController,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(30),  // Make the indicator rounded
              color: Colors.blueAccent,  // Change indicator color for a modern look
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ),
            tabs: const [
              Tab(text: 'GIRLS'),
              Tab(text: 'BOYS'),
              Tab(text: 'MEN'),
              Tab(text: 'WOMEN'),
              Tab(text: 'NEW IN'),
              Tab(text: 'FOOTBALL'),
              Tab(text: 'SCHOOL SHOP'),
              Tab(text: 'SUMMER CLEARANCE'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          Center(child: Text('Girls Page', style: TextStyle(fontSize: 18))),
          Center(child: Text('Boys Page', style: TextStyle(fontSize: 18))),
          Center(child: Text('Men Page', style: TextStyle(fontSize: 18))),
          Center(child: Text('Women Page', style: TextStyle(fontSize: 18))),
          Center(child: Text('New in Page', style: TextStyle(fontSize: 18))),
          Center(child: Text('Football Page', style: TextStyle(fontSize: 18))),
          Center(child: Text('School Shop Page', style: TextStyle(fontSize: 18))),
          Center(child: Text('Summer Clearance Page', style: TextStyle(fontSize: 18))),
        ],
      ),
    );
  }
}


class ImageItemWidget extends StatelessWidget {
  final String image;
  final String text;
  final GestureTapCallback onTap;

  const ImageItemWidget({
    required this.image,
    required this.text,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 340, // Explicit height for the image item
        width: MediaQuery.of(context).size.width, // Explicit width for the image item
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), // Rounded corners
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover, // Cover to maintain aspect ratio
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // Shadow effect
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

Widget buildSocialIcon(IconData icon, Color bgColor) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: CircleAvatar(
      radius: 20,
      backgroundColor: bgColor.withOpacity(0.2),
      child: Icon(icon, color: bgColor, size: 24),
    ),
  );
}


Widget buildActionButton({required IconData icon, required String label, required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.teal.withOpacity(0.1),
          child: Icon(icon, color: Colors.teal, size: 28),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    ),
  );
}
