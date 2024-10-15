class Product {
  final int id;
  final String name;
  final String category;
  final String image;
  final String description;
  final double price;


  final double reducedPrice;
  final List carouselImage;
  int quantity;

  Product(this.id, this.name, this.category, this.description, this.image,
      this.price, this.quantity, this.reducedPrice, this.carouselImage);
}
