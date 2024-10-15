import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/provider/favorite_provider.dart';

import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final Product products;
  const ProductCard({super.key, required this.products});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(

          width: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.green.withOpacity(0.1)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => provider.toggleFavorite(widget.products),
                    child: Icon(
                      provider.isProductExist(widget.products)
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              Image.asset(
                widget.products.image,
                fit: BoxFit.fill,
              ),
              Text(
                '\$' '${widget.products.price}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

          Flexible(
            child: RichText(
              overflow: TextOverflow.clip,
              strutStyle: StrutStyle(fontSize: 12.0),
              text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  text:  widget.products.description.toString()),
            ),
    ),],
          ),
        ),
      ),
    );
  }
}
