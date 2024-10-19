import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
      'assets/images/markerEBike.png',
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
          topRight: Radius.circular(
              50), // Optional to make both corners rounded
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
                  imagePath: 'assets/images/orangeEBike.png',
                  title: 'GT Spot',
                  price: '\$0.30',
                  speed: '46 km/h',
                  onTap: () {Get.offNamed('/scooters');}


                    ),
                SizedBox(width: 15),
                _buildScooterOption(
                  imagePath: 'assets/images/grayEBike.png',
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
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '25°C',
                        style: TextStyle(
                          color: Colors.white,
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
          // Floating Scan Button with Background Gradient
          Positioned(
            bottom: 20,
            left: MediaQuery
                .of(context)
                .size
                .width / 2 - 40,
            child: FloatingActionButton.extended(
              onPressed: () {},
              icon: Icon(Icons.qr_code_scanner),
              label: Text('Scan'),
              backgroundColor: Colors.blueGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          // Slide-in Custom Menu
         // Get.offNamed('/menuScreen'),
          SlideTransition(
            position: _offsetAnimation,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: 280,
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 15,
                          spreadRadius: 5,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back, color: Colors.black),
                              onPressed: () {
                                // Close the menu when "Back" is pressed
                                setState(() {
                                  _isMenuVisible = false;
                                  _controller.reverse();
                                });
                              },
                            ),

                          ],
                        ),
                        SizedBox(height: 15),
                        // Profile Section
                        Row(
                          children: [

                            CircleAvatar(
                              radius: 35,
                              backgroundImage: AssetImage('assets/images/profile.jpg'),
                            ),
                            SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Matt Scott',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 4),
                                GestureDetector(
                                  onTap: () {
                                    // Navigate to profile page
                                  },
                                  child: Text(
                                    'View Profile',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 14,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Divider(color: Colors.grey[300], thickness: 1),
                        SizedBox(height: 20),
                        // Scooter and Location Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.electric_scooter, color: Colors.blueAccent),
                                SizedBox(width: 10),
                                Text(
                                  '0',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.location_on, color: Colors.redAccent),
                                SizedBox(width: 10),
                                Text(
                                  '0 km',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Divider(color: Colors.grey[300], thickness: 1),
                        SizedBox(height: 20),
                        // Menu Items
                        _buildMenuItem(
                          icon: Icons.payment,
                          label: 'Payments',
                          onTap: () {},
                        ),
                        _buildMenuItem(
                          icon: Icons.history,
                          label: 'Ride History',
                          onTap: () {},
                        ),
                        _buildMenuItem(
                          icon: Icons.local_offer,
                          label: 'Promos',
                          onTap: () {},
                        ),
                        _buildMenuItem(
                          icon: Icons.card_membership,
                          label: 'Ride Pass',
                          onTap: () {},
                        ),
                        _buildMenuItem(
                          icon: Icons.help,
                          label: 'Help',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
