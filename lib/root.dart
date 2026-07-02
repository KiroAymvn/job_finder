// import 'package:flutter/material.dart';
// import 'package:job_finder/core/utils/app_colors.dart';
// import 'package:job_finder/features/onboarding/presentation/screen/splash_screen.dart';
// import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
//
// class Root extends StatelessWidget {
//   const Root({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SplashScreen(),
//       bottomNavigationBar: Container(
//         width: double.infinity,
//         height: 50,
//         decoration: BoxDecoration(
//           color: AppColors.kPrimary
//         ),
//       ),
//     );
//   }
// }
// void main() => runApp(PersistenBottomNavBarDemo());
//
// class PersistenBottomNavBarDemo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Persistent Bottom Navigation Bar Demo',
//       home: PersistentTabView(
//         tabs: [
//           PersistentTabConfig(
//             screen: SplashScreen(),
//             item: ItemConfig(
//               icon: Icon(Icons.home),
//               title: "Home",
//             ),
//           ),
//           PersistentTabConfig(
//             screen: on(),
//             item: ItemConfig(
//               icon: Icon(Icons.message),
//               title: "Messages",
//             ),
//           ),
//           PersistentTabConfig(
//             screen: YourThirdScreen(),
//             item: ItemConfig(
//               icon: Icon(Icons.settings),
//               title: "Settings",
//             ),
//           ),
//         ],
//         navBarBuilder: (navBarConfig) => Style1BottomNavBar(
//           navBarConfig: navBarConfig,
//         ),
//       ),
//     );
//   }
// }