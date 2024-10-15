import 'package:ecommerce_app/model/product_category.dart';
import 'package:flutter/material.dart';

class ProductCategoryPage extends StatefulWidget {
  const ProductCategoryPage({super.key});

  @override
  State<ProductCategoryPage> createState() => _ProductCategoryPageState();
}

class _ProductCategoryPageState extends State<ProductCategoryPage> {
  final ValueNotifier<int> isSelected = ValueNotifier<int>(0);
  final List<String> categories = [
    'Mens', 'Women', 'Sports', 'Boys', 'Girls', 'Brands', 'Arabia', 'Clearance'
  ];

  Widget buildCategory(int index, String name) {
    return GestureDetector(
      onTap: () {
        isSelected.value = index;
      },
      child: ValueListenableBuilder<int>(
        valueListenable: isSelected,
        builder: (context, selected, _) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 40,
            width: 100,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected == index ? Colors.blueAccent : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20),
              boxShadow: selected == index
                  ? [BoxShadow(color: Colors.blueAccent.withOpacity(0.5), blurRadius: 10)]
                  : [BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 5)],
            ),
            child: Text(
              name,
              style: TextStyle(
                color: selected == index ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
      ),
    );
  }

  buildSortAndFilterRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActionButton(
          context,
          icon: Icons.sort,
          label: 'Sort',
          onPressed: () {
            // Handle sort action
          },
        ),
        _buildActionButton(
          context,
          icon: Icons.filter_list,
          label: 'Filter',
          onPressed: () {
            showFilterPopUp(context);
          },
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, {required IconData icon, required String label, required VoidCallback onPressed}) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.2,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black26, width: 1),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 8)],
      ),
      child: TextButton.icon(
        icon: Icon(icon, color: Colors.blueAccent),
        label: Text(label, style: TextStyle(color: Colors.blueAccent)),
        onPressed: onPressed,
      ),
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
                  onChanged: (bool? value) {},
                ),
                CheckboxListTile(
                  title: const Text('Option 2'),
                  value: false,
                  onChanged: (bool? value) {},
                ),
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
            ElevatedButton(
              child: const Text('Apply'),
              onPressed: () {
                // Handle apply filter
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildGridView(List<Category> categories) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: (2 / 2.5), // Modern aspect ratio
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2),
      scrollDirection: Axis.vertical,
      itemCount: categories.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final viewall = categories[index];
        return GestureDetector(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 6)],
                    image: DecorationImage(
                      image: AssetImage(viewall.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                viewall.category,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildContent() {
    final selectedCategory = ProductCategory.allcategories;
    return buildGridView(selectedCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(categories.length, (index) => buildCategory(index, categories[index])),
            ),
          ),
          const SizedBox(height: 15),
          buildSortAndFilterRow(context),
          const SizedBox(height: 10),
          Expanded(
            child: ValueListenableBuilder<int>(
              valueListenable: isSelected,
              builder: (context, selected, _) {
                return buildContent();
              },
            ),
          ),
        ],
      ),
    );
  }
}
