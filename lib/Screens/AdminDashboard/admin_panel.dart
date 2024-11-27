import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ocean_view_e_scooters/Screens/AdminDashboard/add_scooter_page.dart';
import 'audience_page.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AdminPanel> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // Header Section
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 60),
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                        title: Text('Admin Hamid!',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white)),
                        subtitle: Text('Ocean View E-Scooter',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white54)),
                        trailing: const CircleAvatar(
                          radius: 28,
                          backgroundImage: AssetImage('assets/images/Hamid2.jpg'),
                        ),
                      ),
                      const SizedBox(height: 35),
                    ],
                  ),
                ),
                // Content Section
                Container(
                  color: Theme.of(context).primaryColor,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(200)),
                    ),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 40,
                      mainAxisSpacing: 30,
                      children: [
                        itemDashboard('Audience', CupertinoIcons.person_2, Colors.purple, () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => AudiencePage()));
                        }),itemDashboard('Scooter', Icons.electric_scooter, Colors.teal, () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => AddScooterPage()));
                        }),
                        itemDashboard('Analytics', CupertinoIcons.graph_circle, Colors.green, () {
                          // Navigator.push(context, MaterialPageRoute(builder: (_) => AnalyticsPage()));
                        }),
                        // itemDashboard('Revenue', CupertinoIcons.money_dollar_circle, Colors.indigo, () {
                          // Navigator.push(context, MaterialPageRoute(builder: (_) => RevenuePage()));
                        // }),
                        itemDashboard('Upload', CupertinoIcons.add_circled, Colors.teal, () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => AddScooterPage()));
                        }),
                        itemDashboard('About', CupertinoIcons.question_circle, Colors.blue, () {
                          // Navigator.push(context, MaterialPageRoute(builder: (_) => AboutPage()));
                        }),
                        itemDashboard('Contact', CupertinoIcons.phone, Colors.pinkAccent, () {
                          // Navigator.push(context, MaterialPageRoute(builder: (_) => ContactPage()));
                        }),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          // Logout Button at the Footer
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ElevatedButton.icon(
              onPressed: () {
                // Handle logout action here
                Get.offNamed('/login'); // Navigate to home if regular user

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              icon: const Icon(Icons.logout, color: Colors.white),
              label: Text(
                'Logout',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Item Dashboard Card
  Widget itemDashboard(String title, IconData iconData, Color background, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 5),
              color: Colors.black.withOpacity(.1),
              spreadRadius: 2,
              blurRadius: 5
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: background,
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(title.toUpperCase(), style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    ),
  );
}
