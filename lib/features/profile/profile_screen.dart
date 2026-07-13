import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasky/core/services/preferences_maneger.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/features/welcome/intro_screen.dart';
import 'package:tasky/features/profile/user_details_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String username;
  late String motivationQuote;
  String? userImageProf;
  bool isloading = true;

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  void _loadUserDetails() async {
    setState(() {
      username = PreferencesManeger().getString('userName') ?? "not found";
      motivationQuote =
          PreferencesManeger().getString('motivattionQuote') ??
          "One task at a time. One step closer.";
      userImageProf = PreferencesManeger().getString("User_image");
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    'My Profile',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                SizedBox(height: 14.0),
                Center(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: userImageProf == null
                                ? AssetImage("assets/images/abdo.png")
                                : FileImage(File(userImageProf!)),
                            radius: 60.0,
                          ),
                          GestureDetector(
                            onTap: () async {
                              XFile? image = await ImagePicker().pickImage(
                                source: ImageSource.gallery,
                              );

                              if (image != null) {
                                final newPath = await _saveProfImage(image);

                                setState(() {
                                  userImageProf = newPath;
                                });
                              }
                            },
                            child: Container(
                              width: 34,
                              height: 34.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Theme.of(
                                  context,
                                ).colorScheme.primaryContainer,
                              ),
                              child: Icon(
                                Icons.camera_enhance_outlined,
                                size: 24.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        username,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Text(
                        motivationQuote,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.0),
                Text(
                  "Profile Info",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(height: 8.0),
                ListTile(
                  onTap: () async {
                    final bool? result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return UserDetailsScreen(
                            username: username,
                            motivationQuote: motivationQuote,
                          );
                        },
                      ),
                    );
                    if (result != null && result) {
                      _loadUserDetails();
                    }
                  },
                  contentPadding: EdgeInsets.zero,
                  title: Text("User details"),
                  leading: Icon(Icons.person, size: 24),
                  trailing: Icon(
                    Icons.arrow_forward,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 24,
                  ),
                ),
                Divider(thickness: 1),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("Dark Mode"),
                  leading: Icon(Icons.dark_mode_outlined, size: 24),
                  trailing: ValueListenableBuilder(
                    valueListenable: ThemeController.themeNotifier,
                    builder: (context, value, child) {
                      return Switch(
                        value: value == ThemeMode.dark,
                        onChanged: (value) {
                          ThemeController.toggleTheme();
                        },
                      );
                    },
                  ),
                ),
                Divider(thickness: 1),
                ListTile(
                  onTap: () async {
                    PreferencesManeger().remove("userName");
                    PreferencesManeger().remove("motivattionQuote");
                    PreferencesManeger().remove("tasks");

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Intro();
                        },
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                  contentPadding: EdgeInsets.zero,
                  title: Text("Log Out"),
                  leading: Icon(Icons.logout, size: 24),
                  trailing: Icon(
                    Icons.arrow_forward,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 24,
                  ),
                ),
              ],
            ),
          );
  }

  Future<String> _saveProfImage(XFile image) async {
    final appDir = await getApplicationDocumentsDirectory();

    final newFile = await File(image.path).copy("${appDir.path}/${image.name}");

    await PreferencesManeger().setString("User_image", newFile.path);

    return newFile.path;
  }
}
