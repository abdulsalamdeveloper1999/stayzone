// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AchievementsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AchievementsPage(),
      );
    },
    BreathingRoute.name: (routeData) {
      final args = routeData.argsAs<BreathingRouteArgs>(
          orElse: () => const BreathingRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: BreathingPage(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    ControlledBreakRoute.name: (routeData) {
      final args = routeData.argsAs<ControlledBreakRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ControlledBreakPage(
          key: args.key,
          appName: args.appName,
          appPackage: args.appPackage,
          appUrlScheme: args.appUrlScheme,
        ),
      );
    },
    EditProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EditProfilePage(),
      );
    },
    HeatmapRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HeatmapPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginPage(),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainPage(),
      );
    },
    NotificationsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NotificationsPage(),
      );
    },
    PaywallRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PaywallPage(),
      );
    },
    PreferencesSetupRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PreferencesSetupPage(),
      );
    },
    ReflectionDelayRoute.name: (routeData) {
      final args = routeData.argsAs<ReflectionDelayRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ReflectionDelayPage(
          key: args.key,
          appName: args.appName,
          onAccepted: args.onAccepted,
          onRejected: args.onRejected,
        ),
      );
    },
    SessionsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SessionsPage(),
      );
    },
    SignUpRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpPage(),
      );
    },
    WelcomeOnboardingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WelcomeOnboardingPage(),
      );
    },
  };
}

/// generated route for
/// [AchievementsPage]
class AchievementsRoute extends PageRouteInfo<void> {
  const AchievementsRoute({List<PageRouteInfo>? children})
      : super(
          AchievementsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AchievementsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [BreathingPage]
class BreathingRoute extends PageRouteInfo<BreathingRouteArgs> {
  BreathingRoute({
    Key? key,
    String? userId,
    List<PageRouteInfo>? children,
  }) : super(
          BreathingRoute.name,
          args: BreathingRouteArgs(
            key: key,
            userId: userId,
          ),
          initialChildren: children,
        );

  static const String name = 'BreathingRoute';

  static const PageInfo<BreathingRouteArgs> page =
      PageInfo<BreathingRouteArgs>(name);
}

class BreathingRouteArgs {
  const BreathingRouteArgs({
    this.key,
    this.userId,
  });

  final Key? key;

  final String? userId;

  @override
  String toString() {
    return 'BreathingRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [ControlledBreakPage]
class ControlledBreakRoute extends PageRouteInfo<ControlledBreakRouteArgs> {
  ControlledBreakRoute({
    Key? key,
    required String appName,
    String? appPackage,
    String? appUrlScheme,
    List<PageRouteInfo>? children,
  }) : super(
          ControlledBreakRoute.name,
          args: ControlledBreakRouteArgs(
            key: key,
            appName: appName,
            appPackage: appPackage,
            appUrlScheme: appUrlScheme,
          ),
          initialChildren: children,
        );

  static const String name = 'ControlledBreakRoute';

  static const PageInfo<ControlledBreakRouteArgs> page =
      PageInfo<ControlledBreakRouteArgs>(name);
}

class ControlledBreakRouteArgs {
  const ControlledBreakRouteArgs({
    this.key,
    required this.appName,
    this.appPackage,
    this.appUrlScheme,
  });

  final Key? key;

  final String appName;

  final String? appPackage;

  final String? appUrlScheme;

  @override
  String toString() {
    return 'ControlledBreakRouteArgs{key: $key, appName: $appName, appPackage: $appPackage, appUrlScheme: $appUrlScheme}';
  }
}

/// generated route for
/// [EditProfilePage]
class EditProfileRoute extends PageRouteInfo<void> {
  const EditProfileRoute({List<PageRouteInfo>? children})
      : super(
          EditProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HeatmapPage]
class HeatmapRoute extends PageRouteInfo<void> {
  const HeatmapRoute({List<PageRouteInfo>? children})
      : super(
          HeatmapRoute.name,
          initialChildren: children,
        );

  static const String name = 'HeatmapRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NotificationsPage]
class NotificationsRoute extends PageRouteInfo<void> {
  const NotificationsRoute({List<PageRouteInfo>? children})
      : super(
          NotificationsRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PaywallPage]
class PaywallRoute extends PageRouteInfo<void> {
  const PaywallRoute({List<PageRouteInfo>? children})
      : super(
          PaywallRoute.name,
          initialChildren: children,
        );

  static const String name = 'PaywallRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PreferencesSetupPage]
class PreferencesSetupRoute extends PageRouteInfo<void> {
  const PreferencesSetupRoute({List<PageRouteInfo>? children})
      : super(
          PreferencesSetupRoute.name,
          initialChildren: children,
        );

  static const String name = 'PreferencesSetupRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ReflectionDelayPage]
class ReflectionDelayRoute extends PageRouteInfo<ReflectionDelayRouteArgs> {
  ReflectionDelayRoute({
    Key? key,
    required String appName,
    required void Function() onAccepted,
    required void Function() onRejected,
    List<PageRouteInfo>? children,
  }) : super(
          ReflectionDelayRoute.name,
          args: ReflectionDelayRouteArgs(
            key: key,
            appName: appName,
            onAccepted: onAccepted,
            onRejected: onRejected,
          ),
          initialChildren: children,
        );

  static const String name = 'ReflectionDelayRoute';

  static const PageInfo<ReflectionDelayRouteArgs> page =
      PageInfo<ReflectionDelayRouteArgs>(name);
}

class ReflectionDelayRouteArgs {
  const ReflectionDelayRouteArgs({
    this.key,
    required this.appName,
    required this.onAccepted,
    required this.onRejected,
  });

  final Key? key;

  final String appName;

  final void Function() onAccepted;

  final void Function() onRejected;

  @override
  String toString() {
    return 'ReflectionDelayRouteArgs{key: $key, appName: $appName, onAccepted: $onAccepted, onRejected: $onRejected}';
  }
}

/// generated route for
/// [SessionsPage]
class SessionsRoute extends PageRouteInfo<void> {
  const SessionsRoute({List<PageRouteInfo>? children})
      : super(
          SessionsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SessionsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignUpPage]
class SignUpRoute extends PageRouteInfo<void> {
  const SignUpRoute({List<PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WelcomeOnboardingPage]
class WelcomeOnboardingRoute extends PageRouteInfo<void> {
  const WelcomeOnboardingRoute({List<PageRouteInfo>? children})
      : super(
          WelcomeOnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeOnboardingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
