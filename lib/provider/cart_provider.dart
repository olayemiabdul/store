import 'package:ecommerce_app/model/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> cart = [];
  List<Product> get itemcart => cart;
  int _quantity = 0;

  int get quantity => _quantity;
  void toggleProduct(Product product) {
    if (cart.contains(product)) {
      for (Product element in cart) {
        element.quantity++;
      }
    } else {
      cart.add(product);
    }
    notifyListeners();
  }

  static CartProvider of(
    BuildContext context, {
    bool listen = true,
  }) {
    return Provider.of<CartProvider>(context, listen: listen);
  }

  getTotalPrice() {
    double total = 0.0;
    for (Product element in cart) {
      total += element.price * element.quantity;
    }
    return total;
  }
  getTotalReducedPrice() {
    double reducedPrice = 0.0;
    for (Product element in cart) {
      reducedPrice += (element.price * element.quantity)-1000;

    }
    return reducedPrice;
  }
  getTotalDiscountedPrice() {
    double discountedPrice = 0.0;
    for (Product element in cart) {
      final totalPrice=element.price*element.quantity;
      final reducedPrice=element.price*element.quantity-1000;
     discountedPrice += totalPrice-reducedPrice;

    }
    return discountedPrice;
  }
  getTotalQuantity() {
    double totalQ = 0.0;
    for (Product element in cart) {
      totalQ += element.quantity;
      notifyListeners();
    }
    return totalQ;

  }
  //to increase cart item
  void addItem(int index) {
    cart[index].quantity++;
    notifyListeners();
  }
  //or use this
  incrementQuantity(int index) {
    cart[index].quantity++;
    notifyListeners();
  }
  //to decrease cart item
  void removeItem(int index) {

      cart[index].quantity--;
      if (cart[index].quantity==0) {
        cart[index].quantity=0;
      }
      notifyListeners();

  }
 //use this
  decrementQuantity(int index) {
    cart[index].quantity--;
    notifyListeners();
  }
}
