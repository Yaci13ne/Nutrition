import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final VoidCallback toggleDarkMode;
  final bool isDarkMode;

  Sidebar({required this.toggleDarkMode, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
accountName: Text(
  "DALACHI YACINE",
  style: TextStyle(
  color:  isDarkMode ?   Color.fromARGB(255, 243, 240, 240) : const Color.fromARGB(255, 0, 0, 0) ,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold, // Makes the text bold
  ),
),
            accountEmail: Text("yacine123@gmail.com", style: TextStyle(color:  isDarkMode ?   Color.fromARGB(255, 243, 240, 240) : const Color.fromARGB(255, 0, 0, 0) ,fontFamily: 'Roboto'),),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=1000&auto=format&fit=crop",
              ),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 76, 175, 80),
                isDarkMode ?   Color.fromARGB(18,18,18,18 ) : const Color.fromARGB(255, 255, 255, 255)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),                    SizedBox(height:20 ,),

          _buildDrawerItem(Icons.person, "My Profile"),
          _buildDrawerItem(Icons.settings, "Settings"),
          _buildDrawerItem(Icons.mail, "Contact Us"),
                    SizedBox(height:50 ,),

          Divider(),
          SizedBox(height: 20,),
          ListTile(
            leading: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round, color:  isDarkMode ?   Color.fromARGB(255, 243, 240, 240) : const Color.fromARGB(255, 0, 0, 0) ),
            title: Text("Dark Mode", style: TextStyle(color:  isDarkMode ?   Color.fromARGB(255, 243, 240, 240) : const Color.fromARGB(255, 0, 0, 0) )),
            onTap: toggleDarkMode,
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text("Log out", style: TextStyle(color: Colors.red)),
            onTap: () {
              // Handle logout
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color:  isDarkMode ?   Color.fromARGB(255, 243, 240, 240) : const Color.fromARGB(255, 0, 0, 0) ),
      title: Text(title, style: TextStyle(color:  isDarkMode ?   Color.fromARGB(255, 243, 240, 240) : const Color.fromARGB(255, 0, 0, 0) )),
      onTap: () {},
    );
  }
}
