import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart' as google_place;

class DeliveryPageScreenN extends StatefulWidget {
  const DeliveryPageScreenN({super.key});

  @override
  _DeliveryPageScreenNState createState() => _DeliveryPageScreenNState();
}

class _DeliveryPageScreenNState extends State<DeliveryPageScreenN> {
  late google_place.GooglePlace googlePlace;
  List<google_place.AutocompletePrediction> predictions = [];
  final postcodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the GooglePlace instance with your API key
    googlePlace = google_place.GooglePlace("AIzaSyDr6l4yKx3-EenoySVVkFAjIOYOMv6s690");
  }

  void findAddressByPostalCode() async {
    if (postcodeController.text.isNotEmpty) {
      try {
        var result = await googlePlace.autocomplete.get(
          postcodeController.text,
          //types: "address", // Ensures results are biased toward addresses
          // Optionally, add location bias (latitude/longitude) to focus on a specific region
          //location: google_place.Location(lat: 51.5074, lng: -0.1278), // Example: London coordinates
          radius: 10000, // Search radius in meters (adjust as needed)
        );

        if (result != null && result.predictions != null) {
          setState(() {
            predictions = result.predictions!;
          });
        } else {
          // Handle empty results
          setState(() {
            predictions = [];
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No address found, please try again.')),
          );
        }
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error fetching address data')),
        );
      }
    }
  }

  void onPlaceSelected(google_place.AutocompletePrediction prediction) async {
    var details = await googlePlace.details.get(prediction.placeId!);
    if (details != null && details.result != null) {
      var result = details.result!;
      // You can use the selected place details here
      print('Selected Place: ${result.formattedAddress}');
      setState(() {
        // You can update other form fields based on the selected address details
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              TextField(
                controller: postcodeController,
                decoration: const InputDecoration(
                  labelText: 'Postcode',
                ),
              ),
              ElevatedButton(
                onPressed: findAddressByPostalCode,
                child: const Text('Find'),
              ),
              if (predictions.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: predictions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(predictions[index].description!),
                      onTap: () => onPlaceSelected(predictions[index]),
                    );
                  },
                )
              else
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text('No addresses found, please try again.'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}


