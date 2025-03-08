import 'package:go_router/go_router.dart';
import 'package:swine_care/feature/bottomnavigationbar/presentation/ScaffoldWithBottomNavBar.dart';
import 'package:swine_care/feature/guide/presentation/widgets/GuidePageWidgets/BestPracticesPage.dart';
import 'package:swine_care/feature/guide/presentation/widgets/GuidePageWidgets/EmergencyMeasuresPage.dart';
import 'package:swine_care/feature/guide/presentation/pages/GuidePage.dart';
import 'package:swine_care/feature/guide/presentation/widgets/GuidePageWidgets/PreventingAfricanSwineFeverPage.dart';
import 'package:swine_care/feature/guide/presentation/widgets/GuidePageWidgets/SwineFarmingPage.dart';
import 'package:swine_care/feature/guide/presentation/widgets/EmergencyTips.dart';
import 'package:swine_care/feature/guide/presentation/widgets/PreventingAfricanSwineFever.dart';
import 'package:swine_care/feature/historypage/presentation/pages/HistoryPage.dart';
import 'package:swine_care/feature/homepage/presentation/pages/HomePage.dart';
import 'package:swine_care/feature/intro/presentation/pages/IntroPage.dart';
import 'package:swine_care/feature/loadingscreen/presentation/pages/LoadingScreen.dart';
import 'package:swine_care/feature/login/presentation/pages/Login.dart';
import 'package:swine_care/feature/register/presentation/pages/Register.dart';
import 'package:swine_care/feature/settings/presentation/pages/Settings.dart';

class RouterConfiguration {
  GoRouter routes() {
    return GoRouter(
      initialLocation: '/loading-screen',
      redirect: (context, state) {
        final currentLocation = state.fullPath;
        print('Redirect Check - Location: $currentLocation'); // Debug print

        // Allow all defined routes to persist without redirecting to /loading-screen
        if (currentLocation!.startsWith('/intro') ||
            currentLocation.startsWith('/loading-screen') ||
            currentLocation.startsWith('/login') ||
            currentLocation.startsWith('/signup') ||
            currentLocation.startsWith('/homepage') ||
            currentLocation.startsWith('/guide') ||
            currentLocation.startsWith('/history') ||
            currentLocation.startsWith('/setting')) {
          print('Allowing Route: $currentLocation');
          return null; // Allow the route to persist
        }

        // Redirect to /loading-screen only for undefined routes
        print('Redirecting to /loading-screen');
        return '/loading-screen';
      },
      routes: [
        GoRoute(
          path: '/intro',
          builder: (context, state) => const IntroPage(),
        ),
        GoRoute(
          path: '/loading-screen',
          builder: (context, state) => const LoadingScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const Login(),
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => const Register(),
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            print('ScaffoldWithBottomNavBar Rebuilt for: ${navigationShell.currentIndex}'); // Debug print
            return ScaffoldWithBottomNavBar(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/homepage',
                  builder: (context, state) => const HomePage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/guide',
                  builder: (context, state) => const GuidePage(),
                  routes: [
                    GoRoute(
                      path: 'swine-farming',
                      builder: (context, state) => const SwineFarmingPage(),
                    ),
                    GoRoute(
                      path: 'best-practices',
                      builder: (context, state) => const BestPracticesPage(),
                    ),
                    GoRoute(
                      path: 'emergency-tips',
                      builder: (context, state) => const EmergencyMeasuresForDiseaseOutbreaks(),
                    ),
                    GoRoute(
                      path: 'emergency',
                      builder: (context, state) => const EmergencyMeasuresPage(),
                    ),
                    GoRoute(
                      path: 'preventing_asf',
                      builder: (context, state) => const PreventingAfricanSwineFever(),
                    ),
                    GoRoute(
                      path: 'preventing',
                      builder: (context, state) => const PreventingAfricanSwineFeverPage(),
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/history',
                  builder: (context, state) => const HistoryPage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/setting',
                  builder: (context, state) => const Settings(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}