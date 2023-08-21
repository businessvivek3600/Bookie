/*import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '/functions/repositories/auth_repo.dart';
import '/repo_injection.dart';
import '/route_management/route_path.dart';
import '/screens/home.dart';
import '/utils/default_logger.dart';
import '/utils/my_dialogs.dart';
import '/widgets/app_web_view_page.dart';

import '../models/user/user_data_model.dart';
import '../providers/auth_provider.dart';
import '../screens/splash_screen.dart';
import '../widgets/page_not_found.dart';
import 'route_animation.dart';
import 'route_name.dart';

class MyRouter {
  static const String tag = 'MyRouter';

  final GoRouter goRouter;

  MyRouter(String? initialRoute) : goRouter = router(initialRoute);

  static GoRouter router(String? initialRoute) => GoRouter(
        navigatorKey: Get.key,
        initialLocation: RoutePath.splash,
        refreshListenable: sl.get<AuthProvider>(),
        debugLogDiagnostics: true,
        routes: <GoRoute>[
          //todo: add your router here
          GoRoute(
              name: RouteName.splash,
              path: RoutePath.splash,
              builder: (BuildContext context, GoRouterState state) =>
                  const SplashScreen()),

          GoRoute(
              name: RouteName.home,
              path: RoutePath.home,
              builder: (BuildContext context, GoRouterState state) =>
                  const Home(),
              routes: [
                GoRoute(
                    name: RouteName.explore,
                    path: RoutePath.explore,
                    pageBuilder: (BuildContext context, GoRouterState state) {
                      return animatedRoute(
                          state,
                          WebViewExample(
                            url: state.queryParameters['url'],
                          ));
                    }),
              ]),
          GoRoute(
            name: RouteName.notFoundScreen,
            path: RoutePath.notFoundScreen,
            builder: (BuildContext context, GoRouterState state) =>
                NotFoundScreen(uri: state.location, state: state),
          ),

          */ /*
        GoRoute(
            name: RouteName.onBoarding,
            path: RoutePath.onBoarding,
            builder: (BuildContext context, GoRouterState state) =>
                const OnBoardingScreen()),
        GoRoute(
            name: RouteName.mlmDash,
            path: RoutePath.mlmDash,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return animatedRoute(state, const MLMDashboardPage());
            }),
        GoRoute(
            name: RouteName.ecomDash,
            path: RoutePath.ecomDash,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return animatedRoute(state, const EcommerceDashboardPage());
            },
            routes: [
              GoRoute(
                  name: RouteName.ecomCategoryPage,
                  path: RoutePath.ecomCategoryPage,
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    return animatedRoute(
                        state,
                        EcomCategoryPage(
                          index:
                              int.parse(state.queryParameters['index'] ?? '0'),
                        ));
                  }),
            ]),
        GoRoute(
            name: RouteName.login,
            path: RoutePath.login,
            builder: (BuildContext context, GoRouterState state) =>
                const LoginScreen()),*/ /*

          ///MLM
          */ /* GoRoute(
            name: RouteName.mLMTransactionPage,
            path: RoutePath.mLMTransactionPage,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return animatedRoute(state, const MLMTransactionPage());
            }),*/ /*

          ///Ecommerce
        ],
        errorPageBuilder: (context, state) => MaterialPage(
            child: NotFoundScreen(state: state, uri: state.location)),
        redirect: guard,
      );

  static Future<String?> guard(
      BuildContext context, GoRouterState state) async {
    String path = state.matchedLocation;
    infoLog('The path is--> ${state.location}');

    var authRepo = sl.get<AuthRepo>();
    await authRepo.saveUser(UserData(status: '2'));
    UserData? user = await authRepo.getUser();

    final bool loggedIn = user != null;
    final bool loggingIn = path == RoutePath.login;
    final bool onBoarding = path == RoutePath.onBoarding;
    infoLog(
        '** routing $path loggedIn $loggedIn   loggingIn $loggingIn **', tag);
    if (!loggedIn && onBoarding) {
      return RoutePath.onBoarding;
    } else if (!loggedIn && loggingIn) {
      return RoutePath.login;
    } else if (!loggedIn && path == RoutePath.splash) {
      return RoutePath.splash;
    } else if (!loggedIn) {
      return RoutePath.login;
    }

    ///user is guest or real
    bool isGuest = true;
    isGuest = user.status == '2';
    infoLog(
        'my router user is logged in $loggedIn, guest $isGuest, status is ${user.status} and path is $path',
        tag);

    ///if user is logged in
    // if user is guest
    if (loggedIn && isGuest) {
      if (path == RoutePath.onBoarding) {
        return RoutePath.ecomDash;
      }
    } else if (loggedIn && !isGuest) {
      // MyDialogs.showQuickLoadingDialog(Get.context!);
      // await Future.delayed(const Duration(seconds: 5));
      // Navigator.pop(Get.context!);
      infoLog('The path is ${state.location}');
      // if (path == RoutePath.onBoarding) {
      //   return RoutePath.home;
      // }
      // else
        if (path.startsWith(RoutePath.home)) {
        infoLog('user is logged in and trying to route in home', tag);
        // await Future.delayed(const Duration(seconds: 5));
        return state.location;
      }
    }
    return null;
  }
}

Copyright 2013 The Flutter Authors. All rights reserved.
Use of this source code is governed by a BSD-style license that can be
found in the LICENSE file.*/

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../screens/App/Booking/slot_booking.dart';
import '../screens/App/Service/service_detail_page.dart';
import '../screens/App/Shop/shopDetailsPage.dart';
import '../screens/Bookings/booking_details_page.dart';
import '/screens/App/Service/services_page.dart';
import '../screens/App/Category/categoryDetailsPage.dart';
import '/screens/User_Preferences/about_page.dart';
import '/screens/User_Preferences/contact_page.dart';
import '/screens/Settings/app_setting_page.dart';
import '/screens/Splash/splash_screen2.dart';
import '/screens/auth/email_registaration_page.dart';
import '../screens/Addresses/AddressMainPage.dart';
import '../screens/Addresses/add_new_address.dart';
import '../screens/App/Category/categories_page.dart';
import '../screens/App/home_search_page.dart';
import '../screens/Notifications/notifications.dart';
import '../screens/Onboardings/on_boarding_page.dart';
import '../screens/Payments/PaymentMethodsMainPage.dart';
import '../screens/Settings/notificationSettingsScreen.dart';
import '../screens/User_Preferences/HelpAndSupport/help_and_support_page.dart';
import '../screens/User_Preferences/profile_screen_page.dart';
import '../screens/auth/PhoneAuthPage.dart';
import '../screens/gallery_page.dart';
import '../widgets/page_not_found.dart';
import 'route_animation.dart';
import 'route_name.dart';
import 'route_path.dart';

import '../screens/auth/login_screen.dart';
import '../screens/App/home.dart';
import '../services/auth_service.dart';
import '../utils/default_logger.dart';
import '../widgets/app_web_view_page.dart';

class MyRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: Get.key,
    initialLocation: RoutePath.splash,
    debugLogDiagnostics: true,
    routes: <GoRoute>[
      GoRoute(
          name: RouteName.home,
          path: RoutePath.home,
          builder: (BuildContext context, GoRouterState state) => const Home(),
          routes: [
            _newRoute2(
                RouteName.search,
                (GoRouterState state) => SearchPage(
                      query: state.queryParameters['query'],
                    ),
                null),
            _newRoute2(
                RouteName.categories,
                (GoRouterState state) => AllCategoriesPage(
                      query: state.queryParameters['category'],
                    ),
                null),
            _newRoute2(RouteName.categoryDetail,
                (GoRouterState state) => const CategoryDetailsPage(), null),
            _newRoute2(
                RouteName.services,
                (GoRouterState state) => AllServicesPage(
                      query: state.queryParameters['service'],
                      category: state.queryParameters['cat'],
                    ),
                null),
            _newRoute2(
                RouteName.service,
                (GoRouterState state) => ServiceDetailsPage(
                      query: state.queryParameters['service'] ?? 'none',
                      shop: state.queryParameters['shop'] ?? 'none',
                    ),
                null,
                routes: [
                  _newRoute2(
                      RouteName.slotBooking,
                      (GoRouterState state) => SlotBookingPage(
                            service: state.queryParameters['service'] ?? 'none',
                            shop: state.queryParameters['shop'] ?? 'none',
                          ),
                      null,
                      ),
                  _newRoute2(
                      RouteName.bookingDetail,
                      (GoRouterState state) => BookingDetailPage(
                            // service: state.queryParameters['service'] ?? 'none',
                            // shop: state.queryParameters['shop'] ?? 'none',
                          ),
                      null,
                      ),
                ]),
            _newRoute2(
                RouteName.shop,
                (GoRouterState state) => ShopDetailPage(
                    shop: state.queryParameters['service'] ?? 'none'),
                null),
            _newRoute2(
                RouteName.explore,
                (GoRouterState state) => WebViewExample(
                    url: state.queryParameters['url'],
                    showAppBar: state.queryParameters['showAppBar'] ?? '1',
                    showToast: state.queryParameters['showToast'] ?? '1',
                    changeOrientation:
                        state.queryParameters['changeOrientation'] ?? '0'),
                null),
            _newRoute2(RouteName.notificationPage,
                (GoRouterState state) => const NotificationPage(), null),
            _newRoute2(RouteName.addressMainPage,
                (GoRouterState state) => const AddressMainPage(), null,
                routes: [
                  _newRoute2(RouteName.addNewAddress,
                      (GoRouterState state) => const AddNewAddress(), null)
                ]),
            _newRoute2(RouteName.paymentMethodsPage,
                (GoRouterState state) => const PaymentMethodsPage(), null),

            _newRoute2(RouteName.profile,
                (GoRouterState state) => const ProfileScreenPage(), null),

            //preferences
            _newRoute2(RouteName.helpAndSupportPage,
                (GoRouterState state) => const HelpAndSupportPage(), null),
            _newRoute2(RouteName.contact,
                (GoRouterState state) => const ContactPage(), null),
            _newRoute2(RouteName.gallery,
                (GoRouterState state) => const GalleryPage(), null),
            _newRoute2(RouteName.appSetting,
                (GoRouterState state) => const AppSettingsPage(), null,
                routes: [
                  _newRoute2(
                      RouteName.notificationSettings,
                      (GoRouterState state) =>
                          const NotificationSettingsScreen(),
                      null)
                ]),
            _newRoute2(RouteName.about,
                (GoRouterState state) => const AboutPage(), null),
          ]),

      ///authentication
      _newRoute2(
          RouteName.login, (GoRouterState state) => const LoginScreen(), null,
          subPath: false),
      _newRoute2(RouteName.phoneAuth,
          (GoRouterState state) => const PhoneAuthPage(), null,
          subPath: false),
      _newRoute2(RouteName.verifyPhoneOTP,
          (GoRouterState state) => const VerifyPhoneOTPPage(), null,
          subPath: false),
      _newRoute2(RouteName.registration,
          (GoRouterState state) => const EmailRegistrationForm(), null,
          subPath: false),
      _newRoute2(RouteName.splash,
          (GoRouterState state) => const SplashScreen2(), null,
          subPath: false),
      _newRoute2(RouteName.onBoarding,
          (GoRouterState state) => const OnBoardingPage(), null,
          subPath: false),
    ],
    errorPageBuilder: (context, state) =>
        animatedRoute(state, NotFoundScreen(state: state, uri: state.location)),
    redirect: _redirect,
  );
}

FutureOr<String?> _redirect(BuildContext context, GoRouterState state) async {
  // Using `of` method creates a dependency of StreamAuthScope. It will
  // cause go_router to reparse current route if StreamAuth has new sign-in
  // information.
  String path = state.matchedLocation;
  final bool loggedIn = await StreamAuthScope.of(context).isSignedIn();
  final bool loggingIn = path == RoutePath.login;

  ///check for on-boarding

  infoLog('path is $path  , user is logged in $loggedIn');
  if (path == RoutePath.splash) {
    return RoutePath.splash;
  }
  if (showOnBoarding) {
    return RoutePath.onBoarding;
  }
  if (!loggedIn && path == RoutePath.registration) {
    return RoutePath.registration;
  } else if (!loggedIn && path == RoutePath.phoneAuth) {
    return RoutePath.phoneAuth;
  } else if (!loggedIn && path == RoutePath.verifyPhoneOTP) {
    return RoutePath.verifyPhoneOTP;
  } else if (!loggedIn) {
    return RoutePath.login;
  }

  // if the user is logged in but still on the login page, send them to
  // the home page
  if (loggingIn) {
    infoLog(
        'path is $path   *contains home  ${path.startsWith(RoutePath.home)}',
        'User is logged in');
    if (path.startsWith(RoutePath.home)) {
      return path;
    } else {
      return RoutePath.home;
    }
  }

  // no need to redirect at all
  return null;
}

GoRoute _newRoute(String name, Widget page, String transition,
        {bool subPath = true}) =>
    GoRoute(
        name: name,
        path: '${!subPath ? '/' : ''}$name',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            animatedRoute(state, page));

GoRoute _newRoute2(String name, Widget Function(GoRouterState state) page,
        RouteTransition? transition,
        {bool subPath = true, List<RouteBase>? routes}) =>
    GoRoute(
        name: name,
        path: '${!subPath ? '/' : ''}$name',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            animatedRoute2(state, page, transition: transition),
        routes: routes ?? []);
