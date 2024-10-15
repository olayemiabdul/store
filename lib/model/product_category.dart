class Category {

  final String category;
  final String image;





  Category( this.category,  this.image,
     );
}
class ProductCategory {
  static List<Category> allcategories= [
    Category('View All', 'assets/images/viewall.png'),
    Category('Footwear', 'assets/images/footwears.png'),
    Category('Clothing', 'assets/images/clothing.png'),
    Category('Accessories', 'assets/images/accessory.png'),
    Category('Outlet', 'assets/images/outlet.png'),
    Category('Trainers', 'assets/images/trainers.png'),
    Category('Football Kits', 'assets/images/football kit.png'),
    Category('Brands', 'assets/images/brands.png'),

  ];
}