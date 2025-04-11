import 'package:flutter/material.dart';
import 'package:flutter_application_1/sidebar.dart';
import 'package:provider/provider.dart';
import 'theme_notifier.dart'; // Import the ThemeNotifier

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        brightness: Brightness.light,
        primarySwatch: Colors.green,
      ),
      darkTheme: ThemeData(
        fontFamily: 'Roboto',
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
      ),
      themeMode: themeNotifier.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? activityRate;
  String userName = "Dalachi Yacine";
  String userEmail = "Dyacine@gmail.com";

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);
    final isDarkMode = themeNotifier.isDarkMode;
    final theme = Theme.of(context);

    return Scaffold(
        drawer: Sidebar(
        toggleDarkMode: () => themeNotifier.toggleTheme(),
        isDarkMode: isDarkMode,
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          // Header with Logo and Avatar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      height: 50,
                      color: isDarkMode ? Colors.white : null,
                    ),
                    Spacer(),
                    
                  ],
                ),
                Text(
                  'Fuel your day with smart nutrition',
                  style: TextStyle(
                    fontSize: 12, 
                    fontFamily: 'Lobster',
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),

          // User Profile Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: theme.cardColor,
                  backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=1000&auto=format&fit=crop",
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name:", 
                          style: TextStyle(
                            fontSize: 16, 
                            fontWeight: FontWeight.bold,
                            color: theme.textTheme.bodyLarge?.color,
                          )),
                      Text(userName, 
                          style: TextStyle(
                            fontSize: 14,
                            color: theme.textTheme.bodyLarge?.color,
                          )),
                      SizedBox(height: 4),
                      Text("Email:", 
                          style: TextStyle(
                            fontSize: 12, 
                            color: theme.textTheme.bodySmall?.color,
                          )),
                      Text(userEmail, 
                          style: TextStyle(
                            fontSize: 12,
                            color: theme.textTheme.bodyLarge?.color,
                          )),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            onPressed: _showEditProfileDialog,
                            icon: Icon(Icons.edit, color: Colors.white),
                            label: Text("Edit profile"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              print("User logged out");
                            },
                            icon: Icon(Icons.exit_to_app, color: Colors.white),
                            label: Text("Log out"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          // Profile Form Section
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDarkMode 
                      ? [Color(0xFF1B5E20), Color(0xFF121212)] 
                      : [Color(0xFF47DF7C), Color(0xFFFFFFFF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode ? Colors.black : Colors.grey.withOpacity(0.2), 
                    blurRadius: 5,
                  ),
                ],
              ),
              child: ListView(
                children: [
                  _buildTextField("Weight", theme),
                  _buildTextField("Height", theme),
                  _buildTextField("Age", theme),
                  SizedBox(height: 10),
                  Text("Activity Rate", 
                      style: TextStyle(
                        fontSize: 16, 
                        color: theme.textTheme.bodyLarge?.color,
                      )),
                  DropdownButtonFormField<String>(
                    value: activityRate,
                    onChanged: (value) {
                      setState(() {
                        activityRate = value;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: "Not Very Active", 
                        child: Text("Not Very Active",
                            style: TextStyle(
                              color: theme.textTheme.bodyLarge?.color,
                            ))),
                      DropdownMenuItem(
                        value: "Quite Active", 
                        child: Text("Quite Active",
                            style: TextStyle(
                              color: theme.textTheme.bodyLarge?.color,
                            ))),
                      DropdownMenuItem(
                        value: "Very Active", 
                        child: Text("Very Active",
                            style: TextStyle(
                              color: theme.textTheme.bodyLarge?.color,
                            ))),
                    ],
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: theme.cardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                    dropdownColor: theme.cardColor,
                    style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        print("Profile saved");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF47DF7C),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 70, vertical: 22),
                      ),
                      child: Text("Save Changes"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, 
              style: TextStyle(
                fontSize: 16, 
                color: theme.textTheme.bodyLarge?.color,
              )),
          TextField(
            keyboardType: TextInputType.number,
            style: TextStyle(color: theme.textTheme.bodyLarge?.color),
            decoration: InputDecoration(
              filled: true,
              fillColor: theme.cardColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditProfileDialog() {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    final isDarkMode = themeNotifier.isDarkMode;
    final theme = Theme.of(context);

    TextEditingController nameController = TextEditingController(text: userName);
    TextEditingController emailController = TextEditingController(text: userEmail);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: theme.dialogBackgroundColor,
          title: Text(
            "Edit Profile",
            style: TextStyle(color: theme.textTheme.titleLarge?.color),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                decoration: InputDecoration(
                  labelText: "Name",
                  labelStyle: TextStyle(color: theme.textTheme.bodyLarge?.color),
                ),
              ),
              TextField(
                controller: emailController,
                style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: theme.textTheme.bodyLarge?.color),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: theme.textTheme.bodyLarge?.color),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  userName = nameController.text;
                  userEmail = emailController.text;
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
              ),
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }
}