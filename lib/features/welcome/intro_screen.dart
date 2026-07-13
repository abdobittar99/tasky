import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/core/reusable_widget/custom_text_formfield.dart';
import 'package:tasky/core/services/preferences_maneger.dart';
import 'package:tasky/features/navigation/home_layout.dart';

class Intro extends StatelessWidget {
  Intro({super.key});
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage("assets/images/Vector.png")),
                    SizedBox(width: 16.0),

                    Text(
                      'Tasky',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                SizedBox(height: 90.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome To Tasky',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    SizedBox(width: 8.0),
                    SvgPicture.asset('assets/images/waving-hand.svg'),
                  ],
                ),
                SizedBox(height: 8.0),
                Text(
                  'Your productivity journey starts here.',
                  style: Theme.of(
                    context,
                  ).textTheme.displaySmall!.copyWith(fontSize: 16),
                ),
                SizedBox(height: 24.0),
                SvgPicture.asset(
                  'assets/images/pana.svg',
                  width: 216.0,
                  height: 200.0,
                ),
                SizedBox(height: 24.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 16.0,
                  ),
                  child: CustomTextFormfield(
                    controller: controller,
                    titel: 'full name',
                    hintText: "e.g Abdo Bittar",
                    validate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "please enter your name";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_key.currentState?.validate() ?? false) {
                      await PreferencesManeger().setString(
                        'userName',
                        controller.value.text,
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return HomeLayout();
                          },
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 40),
                  ),
                  child: Text('Let’s Get Started'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
