import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thermocall_new2/view/account/account_screen.dart';

import 'res/theme/theme.dart';
import 'view/dashboard/dashboard_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ThermoCall',
        themeMode: ThemeMode.system,
        theme: AppTheme().lightTheme(),
        darkTheme: AppTheme().darkTheme(),
        home: ContainerScreen(),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}

class ContainerScreen extends StatefulWidget {
  ContainerScreen({super.key}) {
    Get.lazyPut(() => NavigationController());
  }

  @override
  State<ContainerScreen> createState() => _ContainerScreenState();
}

class _ContainerScreenState extends State<ContainerScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final NavigationController navigationController = Get.find();

    final List<Widget> widgetOptions = [
      DashboardScreen(), // 0
      const AccountScreen(), // 1
    ];

    return Obx(
      () => Scaffold(
        body: widgetOptions[navigationController.currentIndex.value],
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: navigationController.currentIndex.value,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.thermostat),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: 'Account',
              ),
            ],
            onTap: (value) {
              navigationController.changeIndex(value);
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: colorScheme.surface,
            selectedItemColor: colorScheme.secondary,
            unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
            selectedLabelStyle: textTheme.bodySmall,
            unselectedLabelStyle: textTheme.bodySmall,
          ),
        ),
      ),
    );
  }
}
