// import 'package:flutter/widgets.dart';
// import 'package:go_router/go_router.dart';

// @TypedGoRoute<SplashRoute>(path: '/')
// class SplashRoute extends GoRouteData {
//   const SplashRoute();

//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return const SplashScreen();
//   }
// }

// @TypedGoRoute<LoginRoute>(path: '/login')
// class LoginRoute extends GoRouteData {
//   const LoginRoute();

//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return const LoginScreen();
//   }
// }

// // Define the StatefulShellRoute for the bottom navigation
// @TypedStatefulShellRoute<NavigationShellRoute>(
//   branches: <TypedStatefulShellBranch>[
//     TypedStatefulShellBranch<BookBranch>(
//       routes: <TypedGoRoute<GoRouteData>>[
//         TypedGoRoute<BookRoute>(path: '/book'),
//       ],
//     ),
//     TypedStatefulShellBranch<FavoriteBranch>(
//       routes: <TypedGoRoute<GoRouteData>>[
//         TypedGoRoute<FavoriteRoute>(path: '/favorite'),
//       ],
//     ),
//     TypedStatefulShellBranch<ProfileBranch>(
//       routes: <TypedGoRoute<GoRouteData>>[
//         TypedGoRoute<ProfileRoute>(path: '/profile'),
//       ],
//     ),
//   ],
// )
// class NavigationShellRoute extends StatefulShellRouteData {
//   const NavigationShellRoute();

//   @override
//   Widget build(BuildContext context, GoRouterState state,
//       StatefulNavigationShell navigationShell) {
//     // This widget is the container for the branches, typically includes the BottomNavigationBar
//     return NavigationScreen(navigationShell: navigationShell);
//   }
// }

// // Define the routes within the branches
// class BookBranch extends StatefulShellBranchData {
//   const BookBranch();
// }

// class BookRoute extends GoRouteData {
//   const BookRoute();

//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return const BookScreen();
//   }
// }

// class FavoriteBranch extends StatefulShellBranchData {
//   const FavoriteBranch();
// }

// class FavoriteRoute extends GoRouteData {
//   const FavoriteRoute();

//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return const FavoriteScreen();
//   }
// }

// class ProfileBranch extends StatefulShellBranchData {
//   const ProfileBranch();
// }

// class ProfileRoute extends GoRouteData {
//   const ProfileRoute();

//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return const ProfileScreen();
//   }
// }

// // Provider for the GoRouter instance
// final routerProvider = Provider<GoRouter>((ref) {
//   return GoRouter(
//     routes: $appRoutes, // Use the generated routes
//     initialLocation: '/', // Start at the splash screen
//     // Add redirect logic here if needed (e.g., check auth state)
//     redirect: (BuildContext context, GoRouterState state) {
//       // Example redirect logic (you'll need to implement actual auth checking)
//       // This is a simplified example
//       final isLoggedIn = false; // Replace with actual auth state from Riverpod

//       // If on login page and logged in, redirect to book
//       if (state.uri.path == '/login' && isLoggedIn) {
//         return '/book';
//       }
//       // If not logged in and trying to access protected routes (book, fav, profile), redirect to login
//       if (!isLoggedIn &&
//           (state.uri.path == '/book' ||
//               state.uri.path == '/favorite' ||
//               state.uri.path == '/profile')) {
//         // Allow splash screen access without login
//         if (state.uri.path == '/') return null;
//         return '/login';
//       }

//       // No redirect
//       return null;
//     },
//     // Add error handling or other router configurations here
//   );
// });

// /// A screen that hosts the BottomNavigationBar and displays the content
// /// of the currently selected navigation branch using StatefulNavigationShell.
// class NavigationScreen extends StatelessWidget {
//   /// The StatefulNavigationShell provided by GoRouter.
//   /// This is used to manage the state and navigation between branches.
//   final StatefulNavigationShell navigationShell;

//   /// Constructor for NavigationScreen.
//   const NavigationScreen({
//     required this.navigationShell,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Scaffold provides the basic app structure, including the BottomNavigationBar.
//     return Scaffold(
//       // The body displays the content of the currently active branch.
//       // navigationShell.widget is the widget for the current branch.
//       body: navigationShell,
//       // The BottomNavigationBar allows switching between the different branches.
//       bottomNavigationBar: BottomNavigationBar(
//         // The current index is determined by the active branch in the navigation shell.
//         currentIndex: navigationShell.currentIndex,
//         // When a tap occurs, navigate to the corresponding branch.
//         onTap: (index) {
//           // goBranch navigates to the branch at the given index.
//           // It preserves the state of the branches using indexedStack.
//           navigationShell.goBranch(
//             index,
//             // Setting initialLocation to true brings you back to the
//             // initial route of the branch if you tap on the already
//             // selected tab. Set to false to stay on the current sub-route.
//             initialLocation: index == navigationShell.currentIndex,
//           );
//         },
//         // Define the items in the BottomNavigationBar.
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.book),
//             label: 'Book',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: 'Favorite',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }
// }
