import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/core/constants/app_size.dart';
import 'package:tasky/core/constants/storage_key.dart';
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
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: AppSize.h16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage("assets/images/Vector.png"),
                        width: AppSize.w42,
                        height: AppSize.h42,
                      ),
                      SizedBox(width: AppSize.w16),

                      Text(
                        'Tasky',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.h16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome To Tasky',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      SizedBox(width: AppSize.w8),
                      SvgPicture.asset('assets/images/waving-hand.svg'),
                    ],
                  ),
                  SizedBox(height: AppSize.h8),
                  Text(
                    'Your productivity journey starts here.',
                    style: Theme.of(
                      context,
                    ).textTheme.displaySmall!.copyWith(fontSize: AppSize.sp16),
                  ),
                  SizedBox(height: AppSize.h24),
                  SvgPicture.asset(
                    'assets/images/pana.svg',
                    width: AppSize.w216,
                    height: AppSize.h204,
                  ),
                  SizedBox(height: AppSize.h28),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSize.h16),
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
                  SizedBox(height: AppSize.h24),
                  ElevatedButton(
                    onPressed: () async {
                      if (_key.currentState?.validate() ?? false) {
                        await PreferencesManeger().setString(
                          StorageKey.username,
                          controller.value.text,
                        );
                        if (!context.mounted) return;
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
                    child: Text('Let’s Get Started'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
