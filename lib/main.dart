import 'dart:ui';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';
import 'package:melonote/myobjectbox.dart';
import 'package:melonote/src/theme.dart';
import 'package:melonote/src/provider/app_provider.dart';
import 'package:melonote/src/screen/desktop.dart';
import 'package:melonote/src/screen/mobile.dart';
import 'package:melonote/src/utils/myobjectbox.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:io' show Platform;

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods like buildOverscrollIndicator and buildScrollbar
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///* Commented out for now
  // if (Platform.isWindows) {
  //  await windowManager.ensureInitialized();
  //   WindowManager.instance.setMinimumSize(const Size(1200, 600));
  //   WindowManager.instance.setMaximumSize(const Size(1200, 600));
  // }
  objectbox = await ObjectBox.create();

  runApp(ChangeNotifierProvider(
    create: (ctx) => AppProvider(),
    child: const MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    // Database().wipeAllData(); // Uncomment to wipe all data for testing
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppProvider>().intializeData();
    });
    return ScreenUtilInit(
        minTextAdapt: true,
        builder: (ctx, child) {
          final screenwidth = ScreenUtil().screenWidth;
          DeviceType deviceType = context.read<AppProvider>().getDeviceType();
          debugPrint(screenwidth.toString());
          debugPrint(deviceType.toString());

          return ToastificationWrapper(
            child: MaterialApp(
              localizationsDelegates: const [
                FlutterQuillLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              scrollBehavior: MyCustomScrollBehavior(),
              theme: myTheme,
              home: Scaffold(
                body: Container(
                  color: Colors.black,
                  child: Builder(
                    builder: (ctx) {
                      if (deviceType == DeviceType.mobile) {
                        return ScreenUtilInit(
                            designSize: const Size(360, 1080),
                            builder: (ctx, child) {
                              return const MobileLayout();
                            });
                      }
                      if (deviceType == DeviceType.tablet) {
                        return ScreenUtilInit(
                            designSize: const Size(600, 1080),
                            builder: (ctx, child) {
                              return const MobileLayout();
                            });
                      }
                      if (deviceType == DeviceType.windows) {
                        return ScreenUtilInit(
                            designSize: const Size(1200, 1080),
                            builder: (ctx, child) {
                              return const DesktopLayout();
                            });
                      }
                      return const SizedBox
                          .shrink(); // Default return statement
                    },
                  ),
                ),
              ),
            ),
          );
        });
  }
}
