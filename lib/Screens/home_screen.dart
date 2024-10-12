import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController mapController;

  // Initial map position
  final LatLng _center = const LatLng(33.6844, 73.0479); // Coordinates for Islamabad

  // List of markers
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  // Method to load markers with an image in them
  void _loadMarkers() {
    _markers.addAll([
      Marker(
        markerId: MarkerId('marker1'),
        position: LatLng(33.6844, 73.0479),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(
          title: 'Marker 1',
          snippet: 'This is marker 1',
        ),
        onTap: () {
          // Show the image when the marker is tapped
          _showMarkerImage();
        },
      ),
      Marker(
        markerId: MarkerId('marker2'),
        position: LatLng(33.7000, 73.0500),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(
          title: 'Marker 2',
          snippet: 'This is marker 2',
        ),
        onTap: () {
          _showMarkerImage();
        },
      ),
    ]);
  }

  // This method will display an image when a marker is tapped
  void _showMarkerImage() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Image.asset(
          'assets/marker_image.png', // Replace with your image
          width: 200,
          height: 200,
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Open drawer or menu action
          },
        ),
        title: Text('Home Screen'),
        actions: [
          Container(
            width: 100,
            height: 50,
            margin: EdgeInsets.only(top: 10, right: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '25°C',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width / 2 - 40,
            child: FloatingActionButton.extended(
              onPressed: () {
                // Action for scan button
              },
              icon: Icon(Icons.qr_code_scanner),
              label: Text('Scan'),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}
