import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utilities/global_variables.dart';

class SlideInMenu extends StatefulWidget {
  final bool isVisible;
  final VoidCallback onClose;

  const SlideInMenu({required this.isVisible, required this.onClose, Key? key})
      : super(key: key);

  @override
  _SlideInMenuState createState() => _SlideInMenuState();
}

class _SlideInMenuState extends State<SlideInMenu> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(SlideInMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Stack(
        children: [
          GestureDetector(
            onTap: widget.onClose, // Background tap to close the menu
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 280,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    spreadRadius: 5,
                    offset: const Offset(0, 5),
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
                           // _isMenuVisible = false;
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
                        backgroundImage: AssetImage(hamidImage),
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
                              Get.offNamed("/viewProfile");
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
    );
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
            const SizedBox(width: 20),
            Text(
              label,
              style: const TextStyle(
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
    super.dispose();
  }
}
