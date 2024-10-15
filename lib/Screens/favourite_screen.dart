import 'package:ecommerce_app/provider/favorite_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    final saveProductList = provider.favorite;
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 20),
            child: Row(
              children: [
                Text(
                  'favorites',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: saveProductList.length,
              itemBuilder: (context, index) {
                return Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          saveProductList.removeAt(index);
                          setState(() {});
                        },
                        backgroundColor: Colors.green.shade100,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        saveProductList[index].name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        saveProductList[index].description,
                        overflow: TextOverflow.ellipsis,
                      ),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.green.shade100,
                        backgroundImage:
                            AssetImage(saveProductList[index].image),
                      ),
                      trailing: Text(
                        '\$${saveProductList[index].price}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      tileColor: Colors.white,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
