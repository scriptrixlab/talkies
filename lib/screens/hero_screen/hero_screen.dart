import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/app_auth_provider.dart';
import '../../utility/permission_util.dart';
import '../auth/QRScannerScreen.dart';
import '../auth/login_screen/login_screen.dart';

class HeroScreen extends StatefulWidget {
  const HeroScreen({super.key});

  @override
  State<HeroScreen> createState() => _HeroScreenState();
}

class _HeroScreenState extends State<HeroScreen> {
  final ScrollController scrollController = ScrollController();

  List<String> images = [
    "assets/png_images/dummy_img1.png",
    "assets/png_images/dummy_img2.png",
    "assets/png_images/dummy_img3.png",
    "assets/png_images/dummy_img1.png",
    "assets/png_images/dummy_img2.png",
    "assets/png_images/dummy_img3.png",
    "assets/png_images/dummy_img1.png",
    "assets/png_images/dummy_img2.png",
    "assets/png_images/dummy_img3.png",
    "assets/png_images/ic_logo.svg.png",
  ];

  List<String> heroImages = [
    "assets/png_images/hero.png",
    "assets/png_images/hero2.png",
  ];

  List<String> links = [
    "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    "https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
    "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
    "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
    "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
    "https://storage.googleapis.com/gtv-videos-bucket/sample/Sintel.jpg",
    "https://storage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4",
    "https://storage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, BoxConstraints constraints) {
        return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: const DecorationImage(
              image: AssetImage("assets/png_images/background.png"),
              fit: BoxFit.cover,
            ),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                const Color(0xFF1A237E),
                Colors.deepPurple.shade500,
              ],
            ),
          ),
          child: Column(
            children: [
              Flexible(
                child: SizedBox(
                  width: constraints.maxWidth > 750
                      ? constraints.maxWidth * 0.8
                      : constraints.maxWidth,
                  child: heroScreenUiBody(images, context, links,
                      scrollController, constraints, heroImages),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

Widget heroScreenUiBody(
    List<String> images,
    BuildContext context,
    List<String> links,
    ScrollController scrollController,
    BoxConstraints constraints,
    List<String> heroImages) {
  AppAuthProvider authProvider =
      Provider.of<AppAuthProvider>(context, listen: false);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SizedBox(
            height: 150,
            width: 100,
            child: Image.asset(
              "assets/png_images/icon.png",
            ),
          ),
        ),
        actions: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: constraints.maxWidth > 750
                  ? Row(
                      children: [
                        Text(
                          "Movies",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Series",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "MyAccount",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  : authProvider.user == null
                      ? InkWell(
                          onTap: () {
                            //if the user is not logged in move to login
                            AppAuthProvider authProvider =
                                Provider.of<AppAuthProvider>(context,
                                    listen: false);
                            if (authProvider.user == null) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                            }
                          },
                          child: const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 40,
                          ),
                        )
                      : DropdownButton<String>(
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 40,
                          ),
                          underline: SizedBox(),
                          // Remove the underline
                          dropdownColor: Colors.deepPurple,
                          // Customize dropdown background color
                          items: const [
                            DropdownMenuItem(
                              value: 'Movies',
                              child: Text(
                                'Movies',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Series',
                              child: Text(
                                'Series',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'MyAccount',
                              child: Text(
                                'MyAccount',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Connect',
                              child: Text(
                                'Connect',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                          onChanged: (String? value) async {
                            if (value == 'MyAccount') {
                              //move the user to the profile page here
                            } else if (value == 'Connect') {
                              bool hasPermission = await PermissionUtils
                                  .checkCameraPermissionStatus();
                              if (hasPermission) {
                                // Permission granted, proceed with your logic
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QRScannerScreen()),
                                );
                              } else {
                                await PermissionUtils.requestCameraPermission();
                                // Handle the case when the permission is denied
                              }
                            }
                          },
                          // Customize dropdown elevation and borderRadius
                          elevation: 8,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                            bottom: Radius.circular(20),
                          ),
                        ),
            ),
          ),
        ],
      ),
      Expanded(
        flex: 3,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: CarouselSlider(
            options: CarouselOptions(
              height: 900.0,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              autoPlay: true,
              aspectRatio: 16 / 6,
            ),
            items: heroImages.map((imagePath) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: AssetImage(imagePath),
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Expanded(
        child: Scrollbar(
          controller: scrollController,
          thumbVisibility: true,
          thickness: 10.0,
          interactive: true,
          child: ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Container(
                        height: 189,
                        width: 110,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                images[index],
                              ),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black,
                        ),
                        // child:
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      const Center(
        child: Text(
          "© Ar ItWorks, LLC, All Rights Reserved",
          style: TextStyle(color: Colors.white),
        ),
      )
    ],
  );
}
