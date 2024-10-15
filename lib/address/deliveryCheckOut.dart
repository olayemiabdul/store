
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_place/google_place.dart' as google_place;
import 'package:geocoding/geocoding.dart' as geocoding;

import '../provider/cart_favorite_details.dart';
import '../provider/cart_provider.dart';


class DeliveryPageScreen extends StatefulWidget {
  const DeliveryPageScreen({super.key});

  @override
  _DeliveryPageScreenState createState() => _DeliveryPageScreenState();
}

class _DeliveryPageScreenState extends State<DeliveryPageScreen> {
  late google_place.GooglePlace googlePlace;
  List<google_place.AutocompletePrediction> predictions = [];
  List<geocoding.Placemark> placemarks = [];
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final contactController = TextEditingController();
  final addressController = TextEditingController();
  final townCityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final postcodeController = TextEditingController();
  String deliveryMethod = '';
  double deliveryCost = 0.0;
  String _address = '';
  bool isDeliveryMethodSelected = false;
  bool isContinueToPaymentClicked = false;
  String selectedDeliveryMethod = '';
  String selectedPaymentMethod = '';
  bool isReturningUser = false;
  bool showAddressForm = false;
  bool showPayment = false;
  bool isAgreementChecked = false;

  String firstName = '';
  String lastName = '';
  String contactNumber = '';
  String address = '';
  String city = '';
  String state = '';
  String country = '';
  String postalCode = '';

  List<String> cartItems = [];

  void navigateToCartItems() async {
    // Navigate to the CartItemScreen and get the updated cart items
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CartDetailsPage(
          cartItems: [],
        ),
      ),
    );

    // Update the cart items if the result is not null
    if (result != null) {
      setState(() {
        cartItems = result;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserAddress();
  }

  Future<void> getUserAddress() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        setState(() {
          _address = userDoc['address'];
          isReturningUser = true;
          showAddressForm = false;
        });
      }
    }
  }

  void onPlaceSelected(google_place.AutocompletePrediction prediction) async {
    setState(() {
      address = prediction.description ?? '';
      addressController.text = address;
    });

    // getting address components
    var details = await googlePlace.details.get(prediction.placeId!);
    if (details != null && details.result != null) {
      var result = details.result!;
      setState(() {
        city = result.addressComponents
                ?.firstWhere(
                    (component) => component.types!.contains('locality'))
                .longName ??
            '';
        state = result.addressComponents
                ?.firstWhere((component) =>
                    component.types!.contains('administrative_area_level_1'))
                .longName ??
            '';
        country = result.addressComponents
                ?.firstWhere(
                    (component) => component.types!.contains('country'))
                .longName ??
            '';
        postalCode = result.addressComponents
                ?.firstWhere(
                    (component) => component.types!.contains('postal_code'))
                .longName ??
            '';

        townCityController.text = city;
        stateController.text = state;
        countryController.text = country;
        postcodeController.text = postalCode;
      });
    }
  }

  void findAddressByPostalCode() async {
    if (postcodeController.text.isNotEmpty) {
      try {
        List<geocoding.Location> locations =
            await geocoding.locationFromAddress(postcodeController.text);

        if (locations.isNotEmpty) {
          List<geocoding.Placemark> allPlacemarks = [];

          // Iterate over each location to get all potential addresses
          for (var location in locations) {
            // Adjust the location slightly to expand the search area
            List<geocoding.Placemark> placemarksFromCoordinates =
                await geocoding.placemarkFromCoordinates(
                    location.latitude, location.longitude);
            allPlacemarks.addAll(placemarksFromCoordinates);

            // Search a bit to the North
            placemarksFromCoordinates =
                await geocoding.placemarkFromCoordinates(
                    location.latitude + 0.001, location.longitude);
            allPlacemarks.addAll(placemarksFromCoordinates);

            // Search a bit to the South
            placemarksFromCoordinates =
                await geocoding.placemarkFromCoordinates(
                    location.latitude - 0.001, location.longitude);
            allPlacemarks.addAll(placemarksFromCoordinates);

            // Search a bit to the East
            placemarksFromCoordinates =
                await geocoding.placemarkFromCoordinates(
                    location.latitude, location.longitude + 0.001);
            allPlacemarks.addAll(placemarksFromCoordinates);

            // Search a bit to the West
            placemarksFromCoordinates =
                await geocoding.placemarkFromCoordinates(
                    location.latitude, location.longitude - 0.001);
            allPlacemarks.addAll(placemarksFromCoordinates);
          }

          // Remove duplicates
          final uniquePlacemarks = {
            for (var placemark in allPlacemarks) placemark.toString(): placemark
          }.values.toList();

          setState(() {
            placemarks = uniquePlacemarks;
          });

          // Debugging output
          print('Placemarks: ${placemarks.length}');
          for (var placemark in placemarks) {
            print(
                'Placemark: ${placemark.street}, ${placemark.locality} ${placemark.subAdministrativeArea}${placemark.administrativeArea}, ${placemark.country}, ${placemark.postalCode}, ${placemark.thoroughfare},${placemark.locality},${placemark.postalCode}');
          }
        }
      } catch (e) {
        // Handle errors here, e.g., show a message to the user

      }
    }
  }

  void onPlaceMarkSelected(geocoding.Placemark placemark) {
    setState(() {
      addressController.text = '${placemark.street}, ${placemark.subLocality}';
      townCityController.text = placemark.thoroughfare ?? '';

      stateController.text = placemark.subAdministrativeArea ?? '';
      countryController.text = placemark.country ?? '';
      postcodeController.text = placemark.postalCode ?? '';
      placemarks = []; // Clear the list after selection
    });
  }

  Future<void> saveUserAddress() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'contact': contactController.text,
        'address': addressController.text,
        'townCity': townCityController.text,
        'state': stateController.text,
        'country': countryController.text,
        'postcode': postcodeController.text,
      });
    }
  }

  void getPlacePredictions(String input) async {
    var result = await googlePlace.autocomplete.get(input);
    if (result != null && result.predictions != null) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        actions: [
          if (showAddressForm && !isReturningUser)
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  saveUserAddress();
                  setState(() {
                    isReturningUser = true;
                    showAddressForm = false;
                    _address = addressController.text;
                  });
                }
              },
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.black),
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Colors.green,
                    child:  Column(
                      children: [
                        const Text(
                          "My Cart",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          provider.getTotalReducedPrice().toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                       Text(provider.getTotalReducedPrice().toString(),),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: navigateToCartItems,
                        child: const Text("View Cart Items"),
                      ),
                      const SizedBox(height: 20),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.shopping_cart),
                        onSelected: (String result) {
                          // Handle item selection if needed
                        },
                        itemBuilder: (BuildContext context) {
                          return cartItems.map((String item) {
                            return PopupMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList();
                        },
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "DELIVERY",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                title: const Text("Standard Delivery"),
                subtitle: const Text("Delivered within 3 - 7 days"),
                trailing: const Text("£4.99"),
                leading: Radio<String>(
                  value: 'Standard Delivery',
                  groupValue: deliveryMethod,
                  onChanged: (value) {
                    setState(() {
                      deliveryMethod = value!;
                      deliveryCost = 4.99;
                      showAddressForm = true;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text("Fast Delivery"),
                subtitle: const Text("Delivered within 1 - 2 days"),
                trailing: const Text("£9.99"),
                leading: Radio<String>(
                  value: 'Fast Delivery',
                  groupValue: deliveryMethod,
                  onChanged: (value) {
                    setState(() {
                      deliveryMethod = value!;
                      deliveryCost = 9.99;
                      showAddressForm = true;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text("Same Day Delivery"),
                subtitle: const Text("Delivered on the same day"),
                trailing: const Text("£14.99"),
                leading: Radio<String>(
                  value: 'Same Day Delivery',
                  groupValue: deliveryMethod,
                  onChanged: (value) {
                    setState(() {
                      deliveryMethod = value!;
                      deliveryCost = 14.99;
                      showAddressForm = true;
                      //showPayment=true;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              if (isReturningUser && !showAddressForm)
                ListTile(
                  title: const Text("Delivery Address"),
                  subtitle: Text(_address),
                  trailing: TextButton(
                    onPressed: () {
                      setState(() {
                        //to change address
                        showAddressForm = true;
                        showPayment = false;
                      });
                    },
                    child: const Text("Change"),
                  ),
                ),
              if (showAddressForm)
                Column(
                  children: [
                    Text('Delivery',
                        style: GoogleFonts.roboto(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'First Name'),
                      validator: (value) =>
                          value!.isEmpty ? 'Enter first name' : null,
                      onSaved: (value) => firstName = value!,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Last Name'),
                      validator: (value) =>
                          value!.isEmpty ? 'Enter last name' : null,
                      onSaved: (value) => lastName = value!,
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Contact Number'),
                      validator: (value) =>
                          value!.isEmpty ? 'Enter contact number' : null,
                      onSaved: (value) => contactNumber = value!,
                    ),
                    TextField(
                      controller: addressController,
                      decoration: const InputDecoration(labelText: 'Address'),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          getPlacePredictions(value);
                        } else {
                          setState(() {
                            predictions = [];
                          });
                        }
                      },
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: predictions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(predictions[index].description!),
                          onTap: () {
                            onPlaceSelected(predictions[index]);
                            setState(() {
                              predictions = [];
                            });
                          },
                        );
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: postcodeController,
                            decoration:
                                const InputDecoration(labelText: 'Postcode'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: findAddressByPostalCode,
                          child: const Text('Find'),
                        ),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: placemarks.length,
                      itemBuilder: (context, index) {
                        geocoding.Placemark placemark = placemarks[index];
                        return ListTile(
                          title: Text(
                              '${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}, ${placemark.postalCode}'),
                          onTap: () => onPlaceMarkSelected(placemark),
                        );
                      },
                    ),
                    TextFormField(
                      controller: townCityController,
                      decoration: const InputDecoration(labelText: 'City'),
                      validator: (value) =>
                          value!.isEmpty ? 'Enter city' : null,
                      onSaved: (value) => city = value!,
                    ),
                    TextFormField(
                      controller: stateController,
                      decoration: const InputDecoration(labelText: 'State'),
                      validator: (value) =>
                          value!.isEmpty ? 'Enter state' : null,
                      onSaved: (value) => state = value!,
                    ),
                    TextFormField(
                      controller: countryController,
                      decoration: const InputDecoration(labelText: 'Country'),
                      validator: (value) =>
                          value!.isEmpty ? 'Enter country' : null,
                      onSaved: (value) => country = value!,
                    ),
                    TextFormField(
                      controller: postcodeController,
                      decoration:
                          const InputDecoration(labelText: 'Postal Code'),
                      validator: (value) =>
                          value!.isEmpty ? 'Enter postal code' : null,
                      onSaved: (value) => postalCode = value!,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          saveUserAddress();
                          setState(() {
                            isReturningUser = true;
                            showAddressForm = false;
                            showPayment = true;
                            _address = addressController.text;
                          });
                        }
                      },
                      child: const Text("Save Address"),
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              const Text(
                "PAYMENT",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              if (showPayment)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isContinueToPaymentClicked = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green, // Text color
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 20.0), // Padding inside the button
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                    ),
                    elevation: 5,
                  ),
                  child: const Text('Continue to Payment',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),

              const SizedBox(height: 20),
              // Display the payment options if "Continue to Payment" was clicked
              if (isContinueToPaymentClicked)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Payment Methods',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    RadioListTile(
                      title: const Text('Klarna - Pay in 3 Monthly Payments'),
                      value: 'klarna',
                      groupValue: selectedPaymentMethod,
                      onChanged: (value) {
                        setState(() {
                          selectedPaymentMethod = value.toString();
                        });
                      },
                    ),

                    RadioListTile(
                      title: const Text('Credit/Debit Card'),
                      value: 'card',
                      groupValue: selectedPaymentMethod,
                      onChanged: (value) {
                        setState(() {
                          selectedPaymentMethod = value.toString();
                        });
                      },
                    ),

                    // Add more payment methods if needed

                    // Display card details fields if "Credit/Debit Card" is selected
                    if (selectedPaymentMethod == 'card') ...[
                      const SizedBox(height: 20),
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Card Number',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'ExpiryDate (MM/YY)',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.datetime,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'CVV',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              obscureText: true,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ListTile(
                        title: const Text('Items', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
                        trailing: Text( provider.getTotalReducedPrice().toString(),),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        title: const Text(
                          'Total',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          '${(provider.getTotalReducedPrice() + deliveryCost).toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ] else if (selectedPaymentMethod == 'klarna') ...[
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.credit_card, size: 40),
                                SizedBox(width: 10),
                                Icon(Icons.paypal, size: 40),
                                SizedBox(width: 10),
                                Icon(Icons.shopping_bag, size: 40),
                                SizedBox(width: 10),
                                Icon(Icons.check_circle_outline, size: 40),
                              ],
                            ),
                            const SizedBox(height: 10),
                            CheckboxListTile(
                              title: RichText(
                                text: const TextSpan(
                                  text: ' ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Enjoy Buyer protection with Klarna. ',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: 'See Payment options.',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              value: isAgreementChecked,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  isAgreementChecked = newValue ?? false;
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'By continuing, I accept the terms of the Klarna Shopping Service and confirm that I have read the Privacy Notice and the Cookie Notice.',
                              style: TextStyle(fontSize: 12),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isAgreementChecked ? Colors.red : Colors.grey, // Button color depends on checkbox state
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                ),
                                onPressed: isAgreementChecked
                                    ? () {
                                  // Handle Klarna payment here

                                }
                                    : null, // Disable the button if the checkbox is not checked
                                child: const Text(
                                  'PAY WITH KLARNA',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              // Add your payment options here
              const SizedBox(height: 20),
              const Text(
                "ORDER CONFIRMATION",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              // Add order confirmation details here
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle order confirmation
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green, // Text color
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 20.0), // Padding inside the button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  elevation: 5,
                ),
                child: const Text("Place Order"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
