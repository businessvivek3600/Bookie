import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '/screens/BottomNav/dash_setting_page.dart';
import '/utils/sized_utils.dart';
import '/utils/text.dart';
import 'package:my_global_tools/widgets/social_login_buttons.dart';
import '/utils/default_logger.dart';

class EmailRegistrationForm extends StatefulWidget {
  const EmailRegistrationForm({super.key});

  @override
  _EmailRegistrationFormState createState() => _EmailRegistrationFormState();
}

class _EmailRegistrationFormState extends State<EmailRegistrationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passFocus = FocusNode();
  final FocusNode _confFocus = FocusNode();
  String? _customValidator(String? value, String field) {
    if (value == null || value.isEmpty) {
      return 'Please enter $field';
    }
    return null;
  }

  String? _passwordValidator(String? value, String field) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm password';
    } else if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _submitForm() {
    primaryFocus?.unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      // Perform registration logic here
      infoLog('Full Name: ${_fullNameController.text}');
      infoLog('Email: ${_emailController.text}');
      infoLog('Password: ${_passwordController.text}');
      infoLog('Confirm Password: ${_confirmPasswordController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => primaryFocus?.unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            // Background image with filter
            // ImageFiltered(
            //   imageFilter: ImageFilter.blur(sigmaX: 35.0, sigmaY: 35.0),
            //   child: assetImages(
            //     PNGAssets.appLogo,
            //     fit: BoxFit.cover,
            //     height: double.infinity,
            //     width: double.infinity,
            //   ),
            // ),
            CustomPaint(
              painter: TopRightCornerPainter(),
              size: Size(Get.size.width, Get.size.height),
            ),
            CustomPaint(
              painter: BottomLeftCornerPainter(),
              size: Size(Get.size.width, Get.size.height),
            ),

            CustomScrollView(
              slivers: [
                /* SliverAppBar(
                  pinned: true,
                  expandedHeight: getWidth * 0.3,
                  // backgroundColor: Colors.transparent,
                  // shadowColor: Colors.transparent,
                  // title: const Text('Registration'),
                  actions: const [ToogleBrightnessButton()],
                  flexibleSpace: const FlexibleSpaceBar(
                    title: Text('Registration'),
                    centerTitle: false,
                  ),
                ),*/
                SliverToBoxAdapter(
                  child: GestureDetector(
                    onTap: () => primaryFocus?.unfocus(),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              height100(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  titleLargeText('Registration', context,
                                      fontSize: 32),
                                  const ToggleBrightnessButton()
                                ],
                              ),
                              height30(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      focusNode: _nameFocus,
                                      controller: _fullNameController,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        fillColor: Colors.white10,
                                        labelText: 'Full Name *',
                                        prefixIcon: Icon(Icons.person,
                                            color:
                                                getTheme.colorScheme.primary),
                                      ),
                                      validator: (value) =>
                                          _customValidator(value, 'full name'),
                                    ),
                                    const SizedBox(height: 16),
                                    TextFormField(
                                      focusNode: _emailFocus,
                                      controller: _emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        fillColor: Colors.white10,
                                        labelText: 'Email *',
                                        prefixIcon: Icon(Icons.email,
                                            color:
                                                getTheme.colorScheme.primary),
                                      ),
                                      validator: (value) =>
                                          _customValidator(value, 'email'),
                                    ),
                                    const SizedBox(height: 16),
                                    TextFormField(
                                      focusNode: _passFocus,
                                      controller: _passwordController,
                                      obscureText: true,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        fillColor: Colors.white10,
                                        labelText: 'Password *',
                                        prefixIcon: Icon(Icons.lock,
                                            color:
                                                getTheme.colorScheme.primary),
                                      ),
                                      validator: (val) =>
                                          _passwordValidator(val, 'password'),
                                    ),
                                    const SizedBox(height: 16),
                                    TextFormField(
                                      focusNode: _confFocus,
                                      controller: _confirmPasswordController,
                                      obscureText: true,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        fillColor: Colors.white10,
                                        labelText: 'Confirm Password *',
                                        prefixIcon: Icon(Icons.lock_outline,
                                            color:
                                                getTheme.colorScheme.primary),
                                      ),
                                      validator: (value) =>
                                          _confirmPasswordValidator(value),
                                    ),
                                    const SizedBox(height: 24),
                                    ElevatedButton(
                                      onPressed: _submitForm,
                                      child: const Text('Register'),
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Already have an account?'),
                                  TextButton(
                                    onPressed: () {
                                      context.pop();
                                    },
                                    child: const Text('Log in'),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Checkbox(
                                    value: true,
                                    onChanged: (value) {
                                      // Handle checkbox value
                                    },
                                  ),
                                  const Text('I agree to the'),
                                  TextButton(
                                    onPressed: () {
                                      // Show user agreement details
                                    },
                                    child: bodyMedText(
                                        'User Agreement', context,
                                        color: getTheme.colorScheme.primary),
                                  ),
                                ],
                              ),
                              height10(spaceDefault),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Transform.scale(
                                      scale: 0.7,
                                      child: FlutterSocialButton(
                                          onTap: () {
                                            primaryFocus?.unfocus();
                                          },
                                          mini: true,
                                          buttonType: ButtonType.phone)),
                                  Transform.scale(
                                      scale: 0.7,
                                      child: FlutterSocialButton(
                                          onTap: () {
                                            primaryFocus?.unfocus();
                                          },
                                          mini: true,
                                          buttonType: ButtonType.google)),
                                  Transform.scale(
                                      scale: 0.7,
                                      child: FlutterSocialButton(
                                          onTap: () {
                                            primaryFocus?.unfocus();
                                          },
                                          mini: true,
                                          buttonType: ButtonType.facebook)),
                                ],
                              ),
                              // Divider(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            GoBackButton(bottom: Get.height-100),
          ],
        ),
      ),
    );
  }
}

class GoBackButton extends StatelessWidget {
  GoBackButton({super.key, required this.bottom});
  double bottom;
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: Get.height - 100,
        left: paddingDefault,
        child: IconButton.filled(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_ios_new_rounded)));
  }
}

class TopRightCornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = getTheme.colorScheme.primary
      ..style = PaintingStyle.fill;
    double w = size.width;
    double h = size.height;
    final path = Path()
      ..moveTo(w, 0)
      ..lineTo(w, size.height * 0.2)
      ..quadraticBezierTo(w * 0.85, h * 0.2, w * 0.77, h * 0.17)
      ..quadraticBezierTo(w * 0.72, h * 0.15, w * 0.71, h * 0.1)
      ..quadraticBezierTo(w * 0.7, h * 0.09, w * 0.65, h * .085)
      ..quadraticBezierTo(w * 0.55, h * 0.08, w * 0.5, 0)
      ..lineTo(size.width * 0.5, 0)
      ..close();

/*    final path = Path()
      ..moveTo(w, 0)
      ..cubicTo(w, size.height * 0.2, size.width * 0.8, size.height * 0.2, size.width * 0.75, 0)
      ..close();*/

    ///wave
/*    final path = Path();

    final double waveWidth = size.width;
    final double waveHeight = 100.0;
    final double waveMidPoint = size.height / 2;
    final double waveFrequency = 0.05;
    final double waveAmplitude = 20.0;

    path.moveTo(0, waveMidPoint);

    for (double x = 0; x < waveWidth; x++) {
      final double y = waveMidPoint +
          sin(x * waveFrequency) * waveAmplitude;
      path.lineTo(x, y);
    }

    path.lineTo(waveWidth, size.height);
    path.lineTo(0, size.height);
    path.close();*/
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class BottomLeftCornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = getTheme.colorScheme.primary
      ..style = PaintingStyle.fill;
    double w = size.width;
    double h = size.height;
    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(w * 0.33, size.height)
      ..quadraticBezierTo(w * 0.35, h * 0.99, w * 0.33, h * 0.95)
      ..quadraticBezierTo(w * 0.3, h * 0.9, w * 0.18, h * 0.87)
      ..quadraticBezierTo(w * 0.10, h * 0.85, w * 0, h * 0.87)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
