import 'package:ecommerce_app/product_category/test.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Screens/product_Screen.dart';

class WomenDrawer extends StatelessWidget {
  const WomenDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:[

          // New In
          buildCategoryTile(
            context,
            title: 'New In',
            icon: Icons.trending_up_rounded,
            subcategories: ['Puma', 'Nike', 'Adidas', 'Under Armour', 'Reebok', 'Gucci', 'Zara'],
          ),
          // All Clothing
          buildCategoryTile(
            context,
            title: 'All Clothing',
            icon: Icons.shopping_bag,
            subcategories: ['Coats & Jackets', 'Joggers', 'T-Shirts', 'Polos', 'Jeans', 'Jumpers', 'Shirts'],
          ),
          // All Footwear
          buildCategoryTile(
            context,
            title: 'All Footwear',
            icon: FontAwesomeIcons.shoelace,
            subcategories: ['Sandals', 'Shoes', 'Trainers', 'Boots'],
          ),
          // Arabian Wears
          buildCategoryTile(
            context,
            title: 'Arabian Wears',
            icon: Icons.style,
            subcategories: ['Jalabia', 'Abayas', 'Thobe', 'Hijab'],
          ),
        ],
      ),
    );
  }

  // Refactored Expansion Tile
  Widget buildCategoryTile(
      BuildContext context, {
        required String title,
        required IconData icon,
        required List<String> subcategories,
      }) {
    return ExpansionTile(
      leading: Icon(icon, color: Colors.pinkAccent),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
      trailing: Icon(
        Icons.keyboard_arrow_down_rounded,
        size: 28,
        color: Colors.grey[600],
      ),
      children: subcategories.map((subcategory) {
        return ListTile(
          title: Text(subcategory),
          onTap: () {
            navigateToSubcategory(context, subcategory);
            print('$subcategory selected');
          },
        );
      }).toList(),
    );
  }
  navigateToSubcategory(BuildContext context,String subcategory) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>  SubcategoryScreen (subcategory: subcategory,),
      ),
    );
  }
}
class MenDrawer extends StatelessWidget {
  const MenDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:[

          // New In
          buildCategoryTile(
            context,
            title: 'New In',
            icon: Icons.new_releases,
            subcategories: ['Puma', 'Nike', 'Adidas', 'Under Armour', 'Reebok', 'Gucci', 'Zara'],
          ),
          // All Clothing
          buildCategoryTile(
            context,
            title: 'All Clothing',
            icon: Icons.shopping_bag,
            subcategories: ['Coats & Jackets', 'Joggers', 'T-Shirts', 'Polos', 'Jeans', 'Jumpers', 'Shirts'],
          ),
          // All Footwear
          buildCategoryTile(
            context,
            title: 'All Footwear',
            icon: Icons.shopping_cart,
            subcategories: ['Sandals', 'Shoes', 'Trainers', 'Boots'],
          ),
          // Arabian Wears
          buildCategoryTile(
            context,
            title: 'Arabian Wears',
            icon: Icons.style,
            subcategories: ['Jalabia', 'Abayas', 'Thobe', 'Hijab'],
          ),
        ],
      ),
    );
  }

  // Refactored Expansion Tile
  Widget buildCategoryTile(
      BuildContext context, {
        required String title,
        required IconData icon,
        required List<String> subcategories,
      }) {
    return ExpansionTile(
      leading: Icon(icon, color: Colors.pinkAccent),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
      trailing: Icon(
        Icons.keyboard_arrow_down_rounded,
        size: 28,
        color: Colors.grey[600],
      ),
      children: subcategories.map((subcategory) {
        return ListTile(
          title: Text(subcategory),
          onTap: () {
            // Handle tap for each subcategory
            print('$subcategory selected');
          },
        );
      }).toList(),
    );
  }
}
class GirlsDrawer extends StatelessWidget {
  const GirlsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:[

          // New In
          buildCategoryTile(
            context,
            title: 'New In',
            icon: Icons.new_releases,
            subcategories: ['Puma', 'Nike', 'Adidas', 'Under Armour', 'Reebok', 'Gucci', 'Zara'],
          ),
          // All Clothing
          buildCategoryTile(
            context,
            title: 'All Clothing',
            icon: Icons.shopping_bag,
            subcategories: ['Coats & Jackets', 'Joggers', 'T-Shirts', 'Polos', 'Jeans', 'Jumpers', 'Shirts'],
          ),
          // All Footwear
          buildCategoryTile(
            context,
            title: 'All Footwear',
            icon: Icons.shopping_cart,
            subcategories: ['Sandals', 'Shoes', 'Trainers', 'Boots'],
          ),
          // Arabian Wears
          buildCategoryTile(
            context,
            title: 'Arabian Wears',
            icon: Icons.style,
            subcategories: ['Jalabia', 'Abayas', 'Thobe', 'Hijab'],
          ),
        ],
      ),
    );
  }

  // Refactored Expansion Tile
  Widget buildCategoryTile(
      BuildContext context, {
        required String title,
        required IconData icon,
        required List<String> subcategories,
      }) {
    return ExpansionTile(
      leading: Icon(icon, color: Colors.pinkAccent),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
      trailing: Icon(
        Icons.keyboard_arrow_down_rounded,
        size: 28,
        color: Colors.grey[600],
      ),
      children: subcategories.map((subcategory) {
        return ListTile(
          title: Text(subcategory),
          onTap: () {
            // Handle tap for each subcategory
            print('$subcategory selected');
          },
        );
      }).toList(),
    );
  }
}
class BoysDrawer extends StatelessWidget {
  const BoysDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:[

          // New In
          buildCategoryTile(
            context,
            title: 'New In',
            icon: Icons.new_releases,
            subcategories: ['Puma', 'Nike', 'Adidas', 'Under Armour', 'Reebok', 'Gucci', 'Zara'],
          ),
          // All Clothing
          buildCategoryTile(
            context,
            title: 'All Clothing',
            icon: Icons.shopping_bag,
            subcategories: ['Coats & Jackets', 'Joggers', 'T-Shirts', 'Polos', 'Jeans', 'Jumpers', 'Shirts'],
          ),
          // All Footwear
          buildCategoryTile(
            context,
            title: 'All Footwear',
            icon: Icons.shopping_cart,
            subcategories: ['Sandals', 'Shoes', 'Trainers', 'Boots'],
          ),
          // Arabian Wears
          buildCategoryTile(
            context,
            title: 'Arabian Wears',
            icon: Icons.style,
            subcategories: ['Jalabia', 'Abayas', 'Thobe', 'Hijab'],
          ),
        ],
      ),
    );
  }

  // Refactored Expansion Tile
  Widget buildCategoryTile(
      BuildContext context, {
        required String title,
        required IconData icon,
        required List<String> subcategories,
      }) {
    return ExpansionTile(
      leading: Icon(icon, color: Colors.pinkAccent),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
      trailing: Icon(
        Icons.keyboard_arrow_down_rounded,
        size: 28,
        color: Colors.grey[600],
      ),
      children: subcategories.map((subcategory) {
        return ListTile(
          title: Text(subcategory),
          onTap: () {
            // Handle tap for each subcategory
            print('$subcategory selected');
          },
        );
      }).toList(),
    );
  }
}
class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:[

          // New In
          buildCategoryTile(
            context,
            title: 'New In',
            icon: Icons.new_releases,
            subcategories: ['Puma', 'Nike', 'Adidas', 'Under Armour', 'Reebok', 'Gucci', 'Zara'],
          ),
          // All Clothing
          buildCategoryTile(
            context,
            title: 'All Clothing',
            icon: Icons.shopping_bag,
            subcategories: ['Coats & Jackets', 'Joggers', 'T-Shirts', 'Polos', 'Jeans', 'Jumpers', 'Shirts'],
          ),
          // All Footwear
          buildCategoryTile(
            context,
            title: 'All Footwear',
            icon: Icons.shopping_cart,
            subcategories: ['Sandals', 'Shoes', 'Trainers', 'Boots'],
          ),
          // Arabian Wears
          buildCategoryTile(
            context,
            title: 'Arabian Wears',
            icon: Icons.style,
            subcategories: ['Jalabia', 'Abayas', 'Thobe', 'Hijab'],
          ),
        ],
      ),
    );
  }

  // Refactored Expansion Tile
  Widget buildCategoryTile(
      BuildContext context, {
        required String title,
        required IconData icon,
        required List<String> subcategories,
      }) {
    return ExpansionTile(
      leading: Icon(icon, color: Colors.pinkAccent),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
      trailing: Icon(
        Icons.keyboard_arrow_down_rounded,
        size: 28,
        color: Colors.grey[600],
      ),
      children: subcategories.map((subcategory) {
        return ListTile(
          title: Text(subcategory),
          onTap: () {
            // Handle tap for each subcategory
            print('$subcategory selected');
          },
        );
      }).toList(),
    );
  }
}
class HolidayDrawer extends StatelessWidget {
  const HolidayDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:[

          // New In
          buildCategoryTile(
            context,
            title: 'New In',
            icon: Icons.new_releases,
            subcategories: ['Puma', 'Nike', 'Adidas', 'Under Armour', 'Reebok', 'Gucci', 'Zara'],
          ),
          // All Clothing
          buildCategoryTile(
            context,
            title: 'All Clothing',
            icon: Icons.shopping_bag,
            subcategories: ['Coats & Jackets', 'Joggers', 'T-Shirts', 'Polos', 'Jeans', 'Jumpers', 'Shirts'],
          ),
          // All Footwear
          buildCategoryTile(
            context,
            title: 'All Footwear',
            icon: Icons.shopping_cart,
            subcategories: ['Sandals', 'Shoes', 'Trainers', 'Boots'],
          ),
          // Arabian Wears
          buildCategoryTile(
            context,
            title: 'Arabian Wears',
            icon: Icons.style,
            subcategories: ['Jalabia', 'Abayas', 'Thobe', 'Hijab'],
          ),
        ],
      ),
    );
  }

  // Refactored Expansion Tile
  Widget buildCategoryTile(
      BuildContext context, {
        required String title,
        required IconData icon,
        required List<String> subcategories,
      }) {
    return ExpansionTile(
      leading: Icon(icon, color: Colors.pinkAccent),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
      trailing: Icon(
        Icons.keyboard_arrow_down_rounded,
        size: 28,
        color: Colors.grey[600],
      ),
      children: subcategories.map((subcategory) {
        return ListTile(
          title: Text(subcategory),
          onTap: () {
            // Handle tap for each subcategory
            print('$subcategory selected');
          },
        );
      }).toList(),
    );
  }
}
class ShopDrawer extends StatelessWidget {
  const ShopDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:[

          // New In
          buildCategoryTile(
            context,
            title: 'New In',
            icon: Icons.new_releases,
            subcategories: ['Puma', 'Nike', 'Adidas', 'Under Armour', 'Reebok', 'Gucci', 'Zara'],
          ),
          // All Clothing
          buildCategoryTile(
            context,
            title: 'All Clothing',
            icon: Icons.shopping_bag,
            subcategories: ['Coats & Jackets', 'Joggers', 'T-Shirts', 'Polos', 'Jeans', 'Jumpers', 'Shirts'],
          ),
          // All Footwear
          buildCategoryTile(
            context,
            title: 'All Footwear',
            icon: Icons.shopping_cart,
            subcategories: ['Sandals', 'Shoes', 'Trainers', 'Boots'],
          ),
          // Arabian Wears
          buildCategoryTile(
            context,
            title: 'Arabian Wears',
            icon: Icons.style,
            subcategories: ['Jalabia', 'Abayas', 'Thobe', 'Hijab'],
          ),
        ],
      ),
    );
  }

  // Refactored Expansion Tile
  Widget buildCategoryTile(
      BuildContext context, {
        required String title,
        required IconData icon,
        required List<String> subcategories,
      }) {
    return ExpansionTile(
      leading: Icon(icon, color: Colors.pinkAccent),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
      trailing: Icon(
        Icons.keyboard_arrow_down_rounded,
        size: 28,
        color: Colors.grey[600],
      ),
      children: subcategories.map((subcategory) {
        return ListTile(
          title: Text(subcategory),
          onTap: () {
            // Handle tap for each subcategory
            print('$subcategory selected');
          },
        );
      }).toList(),
    );
  }
}
