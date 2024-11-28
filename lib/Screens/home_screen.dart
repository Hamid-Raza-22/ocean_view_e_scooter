import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ocean_view_e_scooters/Screens/Components/custom_manu_option.dart';
import 'package:ocean_view_e_scooters/Utilities/global_variables.dart';

import 'Components/custom_bottom_sheet.dart';
import 'Components/custom_button.dart';
import 'menu_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(33.6844, 73.0479);
  final Set<Marker> _markers = {};
  bool _isMenuVisible = false;

  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _loadMarkers();

    // Initialize animation for menu slide-in effect
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0.0), // Starting position
      end: Offset(0.0, 0.0), // Target position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
  }

  Future<void> _loadMarkers() async {
    final BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48, 48)),
      markerEBike,
    );

    setState(() {
      _markers.addAll([
        Marker(
          markerId: MarkerId('marker1'),
          position: LatLng(33.6844, 73.0479),
          icon: markerIcon,
          infoWindow: InfoWindow(
            title: 'Marker 1',
            snippet: 'This is marker 1',
          ),
          onTap: () {
            // Use showModalBottomSheet to open the scooter modal
            _showScooterModal();
          },
        ),
        Marker(
          markerId: MarkerId('marker2'),
          position: LatLng(33.7000, 73.0500),
          icon: markerIcon,
          infoWindow: InfoWindow(
            title: 'Marker 2',
            snippet: 'This is marker 2',
          ),
          onTap: () {
            // Use showModalBottomSheet to open the scooter modal
            _showScooterModal();
          },
        ),
      ]);
    });
  }

  void _showScooterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return _buildScooterModal();
      },
    );
  }  void _showReports() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return CustomManuOption(title: "Report", onTap: () => Get.offNamed("/reportIssues"),);
      },
    );
  }
  Widget _buildReportModal() {
    return Container(
      width: double.infinity,
      height: 430, // Or any value suitable for your screen size
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        //   colors: [Color(0xFF00E276), Color(0xFF007A3D)],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
        color: Colors.black45,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50), // Optional to make both corners rounded
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 6,
            spreadRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Line separator
            Container(
              width: 50,
              height: 4,
              margin: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 20),
            // Title Text
            Text(
              "Quick support",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 25),
            // Scooter Options
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
             CustomManuOption(title: "title", onTap: () => Get.offNamed("/reportIssues")),
                SizedBox(width: 15),

              ],
            ),
            SizedBox(height: 20),

            //SizedBox(height: 20), // Space to avoid overflow
          ],
        ),
      ),
    );
  }
  Widget _buildScooterModal() {
    return Container(
      width: double.infinity,
      height: 430, // Or any value suitable for your screen size
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        //   colors: [Color(0xFF00E276), Color(0xFF007A3D)],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
        color: Colors.black45,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50), // Optional to make both corners rounded
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 6,
            spreadRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Line separator
            Container(
              width: 50,
              height: 4,
              margin: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 20),
            // Title Text
            Text(
              "Choose Your Scooter Type",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 25),
            // Scooter Options
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildScooterOption(
                  imagePath: orangeEBike,
                  title: 'GT Spot',
                  price: '\$0.30',
                  speed: '46 km/h',
                  onTap: () {Get.offNamed('/scooters');}


                    ),
                SizedBox(width: 15),
                _buildScooterOption(
                  imagePath: grayEBike,
                  title: 'GT Spot Pro',
                  price: '\$0.40',
                  speed: '50 km/h',
                    onTap: () {Get.offNamed('/GTSLscooters');}

                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Nearest Text
                  Text(
                    'Nearest: 150m',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 20),
                  // Unlock Button
                  ElevatedButton(
                    onPressed: () {
                      Get.offNamed("/QrScreen");
                      // Unlock action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.withOpacity(0.9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // Ensures the button takes up only the needed width
                      children: [
                        Text(
                          'Unlock',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8), // Add space between text and icon
                        Icon(Icons.arrow_forward_sharp, color: Colors.white),
                      ],
                    ),
                  )

                ]),
            //SizedBox(height: 20), // Space to avoid overflow
          ],
        ),
      ),
    );
  }

  Widget _buildScooterOption({
    required String imagePath,
    required String title,
    required String price,
    required String speed,
    required VoidCallback onTap, // Add this parameter
  }) {
    return GestureDetector(
      onTap: onTap, // Handle the tap event
      child: Container(
        width: 160,
        height: 220,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.green, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 5,
              offset: Offset(3, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, width: 140, height: 100),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Per min: $price',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Speed: $speed',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _toggleMenu() {
    setState(() {
      _isMenuVisible = !_isMenuVisible;
      if (_isMenuVisible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      if (_isMenuVisible) {
        // If the menu is visible, close it instead of navigating back
        setState(() {
          _isMenuVisible = false;
          _controller.reverse();
        });
        return false; // Prevents app from closing
      }
      return true; // Allows normal back navigation
    },
    child: Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 12.0,
            ),
            markers: _markers,
          ),
          // Custom Positioned AppBar
          Positioned(
            top: 40,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.menu, color: Colors.black),
                  onPressed: _toggleMenu,
                ),
                Container(
                  width: 110,
                  height: 50,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: Offset(0,4 ),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '25°C',
                        style: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Cloudy',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width * 0.75,
            right: MediaQuery.of(context).size.width * 0.08,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.16,
              height: MediaQuery.of(context).size.height * 0.06,
              child: CustomButton(
                icon: Icons.question_mark_rounded,
                iconSize: 18,
                iconColor: Colors.black,
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                gradientColors: const [
                  Colors.white,
                  Colors.white,
                ], // Custom gradient
                onTap: () {
                  debugPrint("Navigating to Past Promo Page");
                  // Get.offNamed('/reportIssues');
                  // _showReports();
                  // showModalBottomSheet(
                  //   context: context,
                  //   shape: const RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.vertical(
                  //       top: Radius.circular(15.0),
                  //     ),
                  //   ),
                  //   //builder: (context) => _buildBottomSheetContent(context),
                  // );
                },
                borderRadius: 15.0,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    offset: const Offset(0, 5),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
          ),

          // Floating Scan Button with Background Gradient
          Positioned(
            child: CustomButton(
              bottom: MediaQuery.of(context).size.height * 0.01,
              top: MediaQuery.of(context).size.height * 0.9,
              left: MediaQuery.of(context).size.width * 0.05,
              width: MediaQuery.of(context).size.width * 0.9,
              height: 50,
              buttonText: 'SCAN',
              icon: Icons.qr_code_scanner_rounded,
              iconSize: 40,
              iconColor: Colors.black,
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              gradientColors: const [buttonColorGreen, buttonColorGreen], // Custom gradient
              onTap: () {
                debugPrint("Navigating to Past Promo Page");
                Get.offNamed('/QrScreen');
              },
              borderRadius: 15.0,
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  offset: Offset(0,5),
                  blurRadius: 10,
                ),
              ],
            ),

          ),
          // Slide-in Custom Menu
         // Get.offNamed('/menuScreen'),
          if (_isMenuVisible)
            SlideInMenu(
              isVisible: _isMenuVisible, // Pass the visibility state
              onClose: () => setState(() => _isMenuVisible = false),
            ),

        ],
      ),
    ));
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: Colors.blueGrey),
            SizedBox(width: 20),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
  }
}
