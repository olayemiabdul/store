import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_place/google_place.dart';

const kGoogleApiKey = "AIzaSyDr6l4yKx3-EenoySVVkFAjIOYOMv6s690"; // Replace with your actual API key

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final formKey = GlobalKey<FormState>();
  String firstName = '';
  String lastName = '';
  String contactNumber = '';
  String address = '';
  String city = '';
  String state = '';
  String country = '';
  String postalCode = '';

  final TextEditingController addressController = TextEditingController();
  final TextEditingController postcodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];

  @override
  void initState() {
    super.initState();
    googlePlace = GooglePlace(kGoogleApiKey);
  }

  void saveAddress() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      // Save the address to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'firstName': firstName,
        'lastName': lastName,
        'contactNumber': contactNumber,
        'address': address,
        'city': city,
        'state': state,
        'country': country,
        'postalCode': postalCode,
      });
    }
  }

  void onPlaceSelected(AutocompletePrediction prediction) async {
    setState(() {
      address = prediction.reference?? '';
      addressController.text = address;
    });

    // Extract address components
    var details = await googlePlace.details.get(prediction.placeId!);
    if (details != null && details.result != null) {
      var result = details.result!;
      setState(() {
        city = result.addressComponents
            ?.firstWhere((component) => component.types!.contains('locality'))
            .longName ??
            '';
        state = result.addressComponents
            ?.firstWhere((component) =>
            component.types!.contains('administrative_area_level_1'))
            .longName ??
            '';
        country = result.addressComponents
            ?.firstWhere((component) => component.types!.contains('country'))
            .longName ??
            '';
        postalCode = result.addressComponents
            ?.firstWhere((component) => component.types!.contains('postal_code'))
            .longName ??
            '';

        cityController.text = city;
        stateController.text = state;
        countryController.text = country;
        postalCodeController.text = postalCode;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Delivery',
                      style: GoogleFonts.roboto(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'First Name'),
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
                    decoration: const InputDecoration(
                        labelText: 'Contact Number'),
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
                  TextFormField(
                    controller: postcodeController,
                    decoration: const InputDecoration(labelText: 'Postcode'),
                  ),
                  TextFormField(
                    controller: cityController,
                    decoration: const InputDecoration(labelText: 'City'),
                    validator: (value) => value!.isEmpty ? 'Enter city' : null,
                    onSaved: (value) => city = value!,
                  ),
                  TextFormField(
                    controller: stateController,
                    decoration: const InputDecoration(labelText: 'State'),
                    validator: (value) => value!.isEmpty ? 'Enter state' : null,
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
                    controller: postalCodeController,
                    decoration:
                    const InputDecoration(labelText: 'Postal Code'),
                    validator: (value) =>
                    value!.isEmpty ? 'Enter postal code' : null,
                    onSaved: (value) => postalCode = value!,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: saveAddress,
                    child: const Text('Continue'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_place/google_place.dart' as google_place;
// import 'package:geocoding/geocoding.dart' as geocoding;
//
// const kGoogleApiKey = "AIzaSyDr6l4yKx3-EenoySVVkFAjIOYOMv6s690"; // Replace with your actual API key
//
// class CheckoutScreen extends StatefulWidget {
//   const CheckoutScreen({super.key});
//
//   @override
//   _CheckoutScreenState createState() => _CheckoutScreenState();
// }
//
// class _CheckoutScreenState extends State<CheckoutScreen> {
//   final formKey = GlobalKey<FormState>();
//   String firstName = '';
//   String lastName = '';
//   String contactNumber = '';
//   String address = '';
//   String _address = '';
//   String city = '';
//   String state = '';
//   String country = '';
//   String postalCode = '';
//   bool isReturningUser = false;
//   bool showAddressForm = false;
//
//   final TextEditingController addressController = TextEditingController();
//   final TextEditingController postcodeController = TextEditingController();
//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController stateController = TextEditingController();
//   final TextEditingController countryController = TextEditingController();
//   final TextEditingController postalCodeController = TextEditingController();
//
//   final firstNameController = TextEditingController();
//   final lastNameController = TextEditingController();
//   final contactController = TextEditingController();
//
//   final townCityController = TextEditingController();
//
//
//
//   late google_place.GooglePlace googlePlace;
//   List<google_place.AutocompletePrediction> predictions = [];
//
//   @override
//   void initState() {
//     super.initState();
//     googlePlace = google_place.GooglePlace(kGoogleApiKey);
//   }
// // use this if not getting user from firebase
//   void saveAddress() async {
//     if (formKey.currentState!.validate()) {
//       formKey.currentState!.save();
//       // Save the address to Firestore
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .set({
//         'firstName': firstName,
//         'lastName': lastName,
//         'contactNumber': contactNumber,
//         'address': address,
//         'city': city,
//         'state': state,
//         'country': country,
//         'postalCode': postalCode,
//       });
//     }
//   }
//   Future<void> saveUserAddress() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
//         'firstName': firstNameController.text,
//         'lastName': lastNameController.text,
//         'contact': contactController.text,
//         'address': addressController.text,
//         'townCity': townCityController.text,
//         'state': stateController.text,
//         'country': countryController.text,
//         'postcode': postcodeController.text,
//       });
//     }
//   }
//
//   void onPlaceSelected(google_place.AutocompletePrediction prediction) async {
//     setState(() {
//       address = prediction.description ?? '';
//       addressController.text = address;
//     });
//
//     // getting address components
//     var details = await googlePlace.details.get(prediction.placeId!);
//     if (details != null && details.result != null) {
//       var result = details.result!;
//       setState(() {
//         city = result.addressComponents
//             ?.firstWhere((component) => component.types!.contains('locality'))
//             .longName ??
//             '';
//         state = result.addressComponents
//             ?.firstWhere((component) =>
//             component.types!.contains('administrative_area_level_1'))
//             .longName ??
//             '';
//         country = result.addressComponents
//             ?.firstWhere((component) => component.types!.contains('country'))
//             .longName ??
//             '';
//         postalCode = result.addressComponents
//             ?.firstWhere((component) => component.types!.contains('postal_code'))
//             .longName ??
//             '';
//
//         cityController.text = city;
//         stateController.text = state;
//         countryController.text = country;
//         postalCodeController.text = postalCode;
//       });
//     }
//   }
//
//   void getPlacePredictions(String input) async {
//     var result = await googlePlace.autocomplete.get(input);
//     if (result != null && result.predictions != null) {
//       setState(() {
//         predictions = result.predictions!;
//       });
//     }
//   }
//
//   void findAddressByPostalCode() async {
//     if (postcodeController.text.isNotEmpty) {
//       try {
//         List<geocoding.Location> locations = await geocoding.locationFromAddress(postcodeController.text);
//         if (locations.isNotEmpty) {
//           geocoding.Location location = locations.first;
//           List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(location.latitude, location.longitude);
//           if (placemarks.isNotEmpty) {
//             geocoding.Placemark placemark = placemarks.first;
//             setState(() {
//               addressController.text = '${placemark.street}, ${placemark.subLocality}';
//               cityController.text = placemark.locality ?? '';
//               stateController.text = placemark.administrativeArea ?? '';
//               countryController.text = placemark.country ?? '';
//             });
//           }
//         }
//       } catch (e) {
//         // Handle errors here, e.g. show a message to the user
//         print(e);
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: const Text('Checkout'),
//       // ),
//       body: SafeArea(
//         child: Form(
//           key: formKey,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Delivery',
//                     style: GoogleFonts.roboto(
//                         fontSize: 20, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 8),
//                 TextFormField(
//                   decoration: const InputDecoration(labelText: 'First Name'),
//                   validator: (value) =>
//                   value!.isEmpty ? 'Enter first name' : null,
//                   onSaved: (value) => firstName = value!,
//                 ),
//                 TextFormField(
//                   decoration: const InputDecoration(labelText: 'Last Name'),
//                   validator: (value) =>
//                   value!.isEmpty ? 'Enter last name' : null,
//                   onSaved: (value) => lastName = value!,
//                 ),
//                 TextFormField(
//                   decoration: const InputDecoration(
//                       labelText: 'Contact Number'),
//                   validator: (value) =>
//                   value!.isEmpty ? 'Enter contact number' : null,
//                   onSaved: (value) => contactNumber = value!,
//                 ),
//                 TextField(
//                   controller: addressController,
//                   decoration: const InputDecoration(labelText: 'Address'),
//                   onChanged: (value) {
//                     if (value.isNotEmpty) {
//                       getPlacePredictions(value);
//                     } else {
//                       setState(() {
//                         predictions = [];
//                       });
//                     }
//                   },
//                 ),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: predictions.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(predictions[index].description!),
//                       onTap: () {
//                         onPlaceSelected(predictions[index]);
//                         setState(() {
//                           predictions = [];
//                         });
//                       },
//                     );
//                   },
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextFormField(
//                         controller: postcodeController,
//                         decoration: const InputDecoration(labelText: 'Postcode'),
//                       ),
//                     ),
//                     SizedBox(width: 8),
//                     ElevatedButton(
//                       onPressed: findAddressByPostalCode,
//                       child: const Text('Find'),
//                     ),
//                   ],
//                 ),
//                 TextFormField(
//                   controller: cityController,
//                   decoration: const InputDecoration(labelText: 'City'),
//                   validator: (value) => value!.isEmpty ? 'Enter city' : null,
//                   onSaved: (value) => city = value!,
//                 ),
//                 TextFormField(
//                   controller: stateController,
//                   decoration: const InputDecoration(labelText: 'State'),
//                   validator: (value) => value!.isEmpty ? 'Enter state' : null,
//                   onSaved: (value) => state = value!,
//                 ),
//                 TextFormField(
//                   controller: countryController,
//                   decoration: const InputDecoration(labelText: 'Country'),
//                   validator: (value) =>
//                   value!.isEmpty ? 'Enter country' : null,
//                   onSaved: (value) => country = value!,
//                 ),
//                 TextFormField(
//                   controller: postalCodeController,
//                   decoration:
//                   const InputDecoration(labelText: 'Postal Code'),
//                   validator: (value) =>
//                   value!.isEmpty ? 'Enter postal code' : null,
//                   onSaved: (value) => postalCode = value!,
//                 ),
//                 const SizedBox(height: 16),
//             ElevatedButton(
//                     onPressed: () {
//                       if (formKey.currentState!.validate()) {
//                         saveUserAddress();
//                         setState(() {
//                           isReturningUser = true;
//                           showAddressForm = false;
//                           _address = addressController.text;
//                         });
//                       }
//                     },
//                     child: const Text("Save Address"),
//                   ),
//                 // ElevatedButton(
//                 //   onPressed:()=> saveUserAddress,
//                 //   child: const Text('Continue'),
//                 // ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
