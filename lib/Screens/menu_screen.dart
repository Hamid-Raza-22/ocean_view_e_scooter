import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen>
    with SingleTickerProviderStateMixin {
  bool _isMenuVisible = false;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  void _toggleMenu() {
    setState(() {
      _isMenuVisible = !_isMenuVisible;
      _isMenuVisible ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildMenuItem(
      {required IconData icon, required String label, required Function onTap}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.black87),
            SizedBox(width: 20),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sliding Menu Example'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: _toggleMenu,
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Text(
              'Main Content',
              style: TextStyle(fontSize: 24),
            ),
          ),
          if (_isMenuVisible)
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
                      padding:
                      EdgeInsets.symmetric(vertical: 40, horizontal: 20),
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
                          // Back Button
                          Row(
                            children: [
                              IconButton(
                                icon:
                                Icon(Icons.arrow_back, color: Colors.black),
                                onPressed: () {
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
                                backgroundImage:
                                AssetImage('assets/images/profile.jpg'),
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
                                  Icon(Icons.electric_scooter,
                                      color: Colors.blueAccent),
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
                                  Icon(Icons.location_on,
                                      color: Colors.redAccent),
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
    );
  }
}
