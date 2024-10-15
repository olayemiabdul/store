import 'package:ecommerce_app/model/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<Product> favorite = [];
  List<Product> get favoriteItem => favorite;
  void toggleFavorite(Product product) {
    if (favorite.contains(product)) {
      favorite.remove(product);
    } else {
      favorite.add(product);
    }
    notifyListeners();
  }

  bool isProductExist(Product product) {
    final isExit = favorite.contains(product);
    return isExit;
  }

  static FavoriteProvider of(
    BuildContext context, {
    bool listen = true,
  }) {
    return Provider.of<FavoriteProvider>(context, listen: listen);
  }
}
