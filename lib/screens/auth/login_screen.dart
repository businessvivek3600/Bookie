import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_global_tools/providers/dashboard_provider.dart';
import 'package:my_global_tools/route_management/route_name.dart';
import 'package:my_global_tools/screens/Onboardings/on_boarding_page.dart';

import '../../models/user/user_data_model.dart';
import '../../repo_injection.dart';
import '../../route_management/my_router.dart';
import '../../route_management/route_path.dart';
import '../../services/auth_service.dart';

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:my_global_tools/constants/asset_constants.dart';
import 'package:my_global_tools/route_management/route_animation.dart';
import 'package:my_global_tools/route_management/route_name.dart';
import 'package:my_global_tools/screens/BottomNav/dash_setting_page.dart';
import 'package:my_global_tools/utils/picture_utils.dart';
import 'package:my_global_tools/utils/sized_utils.dart';
import 'package:my_global_tools/utils/text.dart';
import 'package:my_global_tools/widgets/social_login_buttons.dart';
import '/utils/default_logger.dart';
import 'email_registaration_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
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

  bool loggingIn = false;
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
      setState(() {
        loggingIn = true;
      });
      StreamAuthScope.of(context)
          .signIn(UserData(status: '1'), onBoarding: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => primaryFocus?.unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            /// Background image with filter
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
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          height100(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              titleLargeText('Welcome back', context,
                                  fontSize: 32),
                              const ToggleBrightnessButton()
                            ],
                          ),
                          bodyLargeText('Good to see you again', context),
                          height30(Get.height * 0.1),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: Column(
                              children: [
                                TextFormField(
                                  focusNode: _emailFocus,
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white10,
                                    labelText: 'Email *',
                                    prefixIcon: Icon(Icons.email,
                                        color: getTheme.colorScheme.primary),
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
                                        color: getTheme.colorScheme.primary),
                                  ),
                                  validator: (val) =>
                                      _passwordValidator(val, 'password'),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () => context
                                          .pushNamed(RouteName.registration),
                                      child: capText(
                                          'Forgot Password?', context,
                                          color: getTheme.colorScheme.primary),
                                    ),
                                  ],
                                ),
                                FilledButton(
                                  onPressed: !loggingIn ? _submitForm : null,
                                  child: (loggingIn)
                                      ? Container(
                                          height: 30,
                                          width: 30,
                                          padding: const EdgeInsets.all(3.0),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 0),
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            value: controller.value,
                                            strokeWidth: 3,
                                          ),
                                        )
                                      : const Text('Sign In'),
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an account?'),
                              TextButton(
                                onPressed: () =>
                                    context.pushNamed(RouteName.registration),
                                child: bodyLargeText('Register', context,
                                    color: getTheme.colorScheme.primary),
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
                                child: bodyMedText('User Agreement', context,
                                    color: getTheme.colorScheme.primary),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  primaryFocus?.unfocus();
                                  StreamAuthScope.of(context)
                                      .signIn(UserData(status: '2'),
                                          onBoarding: false)
                                      .then((value) =>
                                          context.go(RoutePath.home));
                                },
                                child: titleLargeText(
                                    'Continue as Guest', context,
                                    color: getTheme.colorScheme.primary),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Transform.scale(
                                  scale: 0.7,
                                  child: FlutterSocialButton(
                                      onTap: () {
                                        primaryFocus?.unfocus();
                                        context.pushNamed(RouteName.phoneAuth);
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
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

/*
/// The login screen.
class LoginScreen extends StatefulWidget {
  /// Creates a [LoginScreen].
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  bool loggingIn = false;
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (loggingIn) CircularProgressIndicator(value: controller.value),
              if (!loggingIn)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      loggingIn = true;
                    });
                    StreamAuthScope.of(context)
                        .signIn(UserData(status: '1'), onBoarding: false)
                        .then((value) =>
                            sl.get<DashboardProvider>().setBottomIndex(0));
                  },
                  child: const Text('Login'),
                ),
              ElevatedButton(
                onPressed: () => context.pushNamed(RouteName.registration),
                child: const Text('Register'),
              ),
              ElevatedButton(
                onPressed: () {
                  StreamAuthScope.of(context)
                      .signIn(UserData(status: '2'), onBoarding: false);
                  context.go(RoutePath.home);
                },
                child: const Text('Continue as Guest'),
              ),
            ],
          ),
        ),
      );
}
*/
