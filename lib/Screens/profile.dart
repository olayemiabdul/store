// // import 'package:flutter/material.dart';
// //
// // class ProfilePage extends StatefulWidget {
// //   const ProfilePage({super.key});
// //
// //   @override
// //   State<ProfilePage> createState() => _ProfilePageState();
// // }
// //
// // class _ProfilePageState extends State<ProfilePage> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('ProfileScreen'),
// //       ),
// //     );
// //   }
// // }
// import 'dart:io';
//
// import 'package:ecommerce_app/provider/favorite_provider.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:share_plus/share_plus.dart';
//
// class ProfilePage extends StatefulWidget {
//   const ProfilePage({Key? key}) : super(key: key);
//
//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   //pdf viwer variables
//   int currentPage = 0;
//   int totalPages = 0;
//   bool isReady = false;
//   String errorMessage = '';
//   PlatformFile? pickedFiles;
//   Future<File?>? pickedPdfFile;
//   UploadTask? uploadTask; // for file download
//   PlatformFile? savedFile;
//   String linkUrl='';
//   final user = FirebaseAuth.instance.currentUser;
//   var overlayController=OverlayPortalController();
//
//
//
//
//   Future<File?> loadPdfFile() async {
//
//     final directory = await getApplicationDocumentsDirectory();
//     final filePath = '${directory.path}/picked_pdf.pdf';
//
//     if (await File(filePath).exists()) {
//       return File(filePath);
//     }
//     return null;
//   }
//   Future<void> pickPdfFile() async {
//
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );
//
//     if (result != null && result.files.single.path != null) {
//       final pickedFile = File(result.files.single.path!);
//       final directory = await getApplicationDocumentsDirectory();
//       final filePath = '${directory.path}/picked_pdf.pdf';
//
//       final savedFile = await pickedFile.copy(filePath);
//
//       setState(() {
//         pickedPdfFile = Future.value(savedFile);
//       });
//     }
//   }
//
//
//
//   //upload to cloud storage
//   Future uploadFile() async {
//     final path = 'storage/${pickedFiles!.name}';
//     final newfile = File(pickedFiles!.path!);
//     final reference = FirebaseStorage.instance.ref().child(path);
//     //reference.putFile(newfile);
//     setState(() {
//       uploadTask = reference.putFile(newfile);
//     });
//     final snapshot = await uploadTask!.whenComplete(() {});
//     final linkDownload = await snapshot.ref.getDownloadURL();
//     print(linkDownload);
//     setState(() {
//       linkUrl=linkDownload;
//     });
//     return linkDownload;
//
//
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     loadPdfFile();
//
//   }
//   shareApp(BuildContext context) {
//     Share.share('Check out this amazing app: https://play.google.com/store/apps/details?id=com.example.yourapp', // Replace with your app's Play Store URL
//         subject: 'Share Our App');
//   }
//   @override
//   Widget build(BuildContext context) {
//     //final provider = Provider.of<FavouritesJob>(context, listen: false);
//     final user = FirebaseAuth.instance.currentUser;
//     var imageUrl = user!.photoURL;
//
//     DateTime selectedDate = DateTime.now();
//
//     Widget item1 = ListTile(
//       leading: const Icon(Icons.verified_user),
//       title: const Text('Profile'),
//       onTap: () => {Navigator.of(context).pop()},
//     );
//     Widget item2 = const ListTile(
//       leading: Icon(Icons.settings),
//       title: Text('Settings'),
//       // onTap: () => Navigator.of(context).push(
//       //   MaterialPageRoute(
//       //     builder: (context) => const ContactUsPage(),
//       //   ),
//       // ),
//     );
//     Widget item3 = ListTile(
//       leading: const Icon(Icons.border_color),
//       title: const Text('Feedback'),
//       onTap: () => {Navigator.of(context).pop()},
//     );
//     Widget title = ListTile(
//       leading: const Icon(Icons.input),
//       title: const Text('App info'),
//       onTap: () => {
//
//       },
//     );
//     Widget item4 = ListTile(
//       leading: const Icon(Icons.exit_to_app),
//       title: const Text('Logout'),
//       onTap: () => {signOutFromGoogle()},
//     );
//
//
//     return ChangeNotifierProvider<FavoriteProvider>(
//       create: (BuildContext context) => FavoriteProvider(),
//       builder: (context, child) {
//
//         return SafeArea(
//           child: Scaffold(
//             appBar: AppBar(
//               backgroundColor: Colors.green,
//               title: const Text(
//                 'Profile',
//                 style: TextStyle(color: Colors.black),
//               ),
//               // actions: [
//               //   PopupMenuButton(
//               //       // color: Colors.white,
//               //       itemBuilder: (context) => [
//               //             PopupMenuItem(
//               //               value: title,
//               //               child: title,
//               //             ),
//               //             PopupMenuItem(
//               //               value: item1,
//               //               child: item1,
//               //             ),
//               //             PopupMenuItem(
//               //               value: item2,
//               //               child: item2,
//               //             ),
//               //             PopupMenuItem(
//               //               value: item3,
//               //               child: item3,
//               //             ),
//               //             PopupMenuItem(
//               //               value: item4,
//               //               child: item4,
//               //             )
//               //           ])
//               // ],
//               actions: [
//
//                 PopupMenuButton(
//                   itemBuilder: (context) => [
//                     PopupMenuItem(
//                       value: 1,
//                       // row with 2 children
//                       child: ElevatedButton(
//                         onPressed: overlayController.toggle,
//                         child: OverlayPortal(
//                           controller: overlayController, overlayChildBuilder: (BuildContext context) {
//                           return Positioned(
//                             top: 250,
//                             right: 40,
//                             child: Container
//                               (
//                               decoration: const BoxDecoration(
//                                   color: Colors.cyan,
//                                   borderRadius: BorderRadius.all(Radius.circular(10))
//                               ),
//                               //color: Colors.green,
//                               height: 330,
//                               width: 300,
//                               child:  const Column(
//                                 children: [
//                                   // const SizedBox(height: 140,),
//                                   Padding(
//                                     padding: EdgeInsets.all(8.0),
//                                     child: Text('Welcome Tuned Jobs\nGrab your next desired dream Job here',
//                                       style: TextStyle(color: Colors.white),),
//                                   ),
//                                   Image(image: AssetImage('assets/images/logo.jpg', ), height: 180,width: 260,),
//                                   SizedBox(height: 2,),
//                                   Text('Version 1.0.1\nDeveloper:olayemi.abdullahi@gmail.com\n07407208778', style: TextStyle(
//                                       color: Colors.white
//                                   ),)
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                           child: const Text('App Info'),
//                         ),
//                       ),
//                     ),
//                     PopupMenuItem(
//                         child: ElevatedButton(onPressed: () {
//                           // Navigator.push(
//                           //   context,
//                           //   MaterialPageRoute(
//                           //     builder: (context) => const  SettingsPageScreen(),
//                           //   ),
//                           // );
//                         }, child: const Text('Settings'),)
//                     ),
//                     PopupMenuItem(
//                       child: Row(
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               shareApp(context);
//                             },
//                             icon: const Icon(Icons.share),
//                           ),
//                           const Text('share'),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             body: Column(
//               children: [
//
//
//                 Padding(
//                   //gmail photo or upload photo
//                   padding: const EdgeInsets.only(left: 20, bottom: 20),
//                   child: Center(child: profilePhotoWidget(imageUrl, user), ),
//                 ),
//
//                 const Center(
//                   child: Text(' Welcome Back',
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 30),
//                   child: Row(
//                     children: [
//                       const SizedBox(
//                         width: 1,
//                       ),
//                       Center(child: nameWidget(user)),
//
//
//                       emailWidget(user),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const Divider(
//                   height: 1,
//                   thickness: 1,
//                   color: Colors.black,
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.only(left: 8),
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.bookmark_add_outlined,
//                         color: Colors.green,
//                         size: 40,
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(bottom: 15),
//                         child: Text(
//                           'My Cv',
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontFamily: 'Poppins-Bold',
//                               fontSize: 14),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Expanded(
//                 //
//                 //   child: FutureBuilder<File?>(
//                 //     future: loadPdfFile(),
//                 //     builder: (context, snapshot) {
//                 //       if (snapshot.connectionState == ConnectionState.waiting) {
//                 //         return const Center(child: CircularProgressIndicator());
//                 //       } else if (snapshot.hasError) {
//                 //         return Center(child: Text('Error: ${snapshot.error}'));
//                 //       } else if (snapshot.hasData && snapshot.data != null) {
//                 //         return Container(
//                 //           width: double.infinity,
//                 //           height: double.infinity,
//                 //           child: SfPdfViewer.file(snapshot.data!),
//                 //         );
//                 //       } else {
//                 //         return const Center(child: Text('No PDF selected'));
//                 //       }
//                 //     },
//                 //   ),
//                 // ),
//                 ElevatedButton(
//                   onPressed: pickPdfFile,
//
//                   child: const Text('Update Cv'),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 // Padding(
//                 //   padding: const EdgeInsets.only(left: 40),
//                 //   child: Row(
//                 //     children: [
//                 //       Container(
//                 //         decoration: BoxDecoration(
//                 //           borderRadius: const BorderRadius.only(
//                 //               topLeft: Radius.circular(10),
//                 //               topRight: Radius.circular(10),
//                 //               bottomLeft: Radius.circular(10),
//                 //               bottomRight: Radius.circular(10)),
//                 //           color: Colors.green,
//                 //           border: Border.all(
//                 //             color: Colors.white,
//                 //             width: 1,
//                 //           ),
//                 //         ),
//                 //         height: 50,
//                 //         width: 150,
//                 //         child: InkWell(
//                 //           onTap: () {
//                 //
//                 //           },
//                 //           child: const Center(
//                 //               child: Text(
//                 //             'Share Resume',
//                 //             style: TextStyle(color: Colors.white, fontSize: 20),
//                 //           )),
//                 //         ),
//                 //       ),
//                 //       const SizedBox(
//                 //         width: 5,
//                 //       ),
//                 //       Container(
//                 //         decoration: BoxDecoration(
//                 //           borderRadius: const BorderRadius.only(
//                 //               topLeft: Radius.circular(10),
//                 //               topRight: Radius.circular(10),
//                 //               bottomLeft: Radius.circular(10),
//                 //               bottomRight: Radius.circular(10)),
//                 //           color: Colors.white,
//                 //           border: Border.all(
//                 //             color: Colors.green,
//                 //             width: 2,
//                 //           ),
//                 //         ),
//                 //         height: 50,
//                 //         width: 150,
//                 //         child: ElevatedButton(
//                 //           onPressed: () =>uploadFile(), child: const   Center(
//                 //           child: Text(
//                 //             'Upload',
//                 //             style:
//                 //             TextStyle(color: Colors.green, fontSize: 20),
//                 //           ),
//                 //         ),
//                 //
//                 //         ),
//                 //       ),
//                 //     ],
//                 //   ),
//                 //
//                 // ),
//
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget profilePhotoWidget(String? imageurl, User user) {
//     try {
//       return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: imageurl != null
//             ? Image.network(user.photoURL.toString(), height: 30,width: 30,)
//             :  const CircleAvatar(radius: 30, child:  Text('No image')),
//       );
//     } catch (e) {
//       return const Text('Check the connectivity');
//     }
//   }
//
//   Widget nameWidget(User user) {
//     try {
//       return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(
//           user.displayName!,
//           style: const TextStyle(
//             fontFamily: 'Poppins Bold',
//             fontSize: 10,
//             color: Colors.brown,
//           ),
//           //   style: Theme.of(context).textTheme.headlineSmall,
//         ),
//       );
//     } catch (e) {
//       return const Text('Check the connectivity');
//     }
//   }
//
//   Widget emailWidget(User user) {
//     try {
//       return Padding(
//         padding: const EdgeInsets.only(left: 16),
//         child: Center(
//           child: Text(
//             user.email.toString(),
//             style: const TextStyle(color: Colors.black),
//           ),
//         ),
//       );
//     } catch (e) {
//       return const Text('check network');
//     }
//   }
// }
//
// // to log out google user and user created using singup method
// Future<void> signOutFromGoogle() async {
//   final GoogleSignIn googleUser = GoogleSignIn();
//   await googleUser.signOut();
//   await FirebaseAuth.instance.signOut();
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile & Wishlist'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileSection(),
            const Divider(thickness: 1),
            OrderHistorySection(),
            const Divider(thickness: 1),
            WishlistSection(),
          ],
        ),
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Profile Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ProfileField(label: 'Name', value: user!.displayName!),
          ProfileField(label: 'Email', value: user!.email!),
          ProfileField(label: 'Address', value: '123 Fashion St, NY'),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Edit Profile'),
          ),
        ],
      ),
    );
  }
}

class ProfileField extends StatelessWidget {
  final String label;
  final String value;

  ProfileField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, color: Colors.grey)),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class OrderHistorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Order History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          OrderCard(orderNumber: '123456', status: 'Delivered', totalAmount: 89.99),
          OrderCard(orderNumber: '654321', status: 'Pending', totalAmount: 49.99),
        ],
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String orderNumber;
  final String status;
  final double totalAmount;

  OrderCard({required this.orderNumber, required this.status, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text('Order #$orderNumber'),
        subtitle: Text('Status: $status'),
        trailing: Text('\$${totalAmount.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
        onTap: () {
          // View order details
        },
      ),
    );
  }
}

class WishlistSection extends StatelessWidget {
  final List<Map<String, dynamic>> wishlistItems = [
    {'name': 'Trendy Sneakers', 'imageUrl': 'https://via.placeholder.com/150', 'price': 49.99},
    {'name': 'Stylish Hat', 'imageUrl': 'https://via.placeholder.com/150', 'price': 19.99},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Wishlist', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.75,
            ),
            itemCount: wishlistItems.length,
            itemBuilder: (context, index) {
              return WishlistCard(item: wishlistItems[index]);
            },
          ),
        ],
      ),
    );
  }
}

class WishlistCard extends StatelessWidget {
  final Map<String, dynamic> item;

  WishlistCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(item['imageUrl'], height: 120, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(item['name'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
          Text('\$${item['price'].toString()}', style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
            child: const Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}
