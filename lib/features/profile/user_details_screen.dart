import 'package:flutter/material.dart';
import 'package:tasky/core/reusable_widget/custom_text_formfield.dart';
import 'package:tasky/core/services/preferences_maneger.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({
    super.key,
    required this.username,
    required this.motivationQuote,
  });
  final String username;
  final String motivationQuote;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final TextEditingController userNameController = TextEditingController();

  final TextEditingController motivationController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey();
  @override
  void initState() {
    userNameController.text = widget.username;
    motivationController.text = widget.motivationQuote;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextFormfield(
                        controller: userNameController,
                        titel: 'User Name',
                        hintText: "AboAlaa",
                        validate: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return " enter user name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.0),
                      CustomTextFormfield(
                        controller: motivationController,
                        titel: 'Motivation Quote',
                        hintText: "One task at a time. One step closer.",
                        maxLines: 5,
                        validate: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return " enter Motivation Quote";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_key.currentState!.validate()) {
                    await PreferencesManeger().setString(
                      'userName',
                      userNameController.value.text,
                    );
                    await PreferencesManeger().setString(
                      "motivattionQuote",
                      motivationController.value.text,
                    );
                    Navigator.of(context).pop(true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                ),
                child: Text("Save changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
