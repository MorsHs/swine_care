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
import 'package:swine_care/feature/homepage/presentation/pages/ResultsPage.dart';
import 'package:swine_care/feature/intro/presentation/pages/IntroPage.dart';
import 'package:swine_care/feature/loadingscreen/presentation/pages/LoadingScreen.dart';
import 'package:swine_care/feature/login/presentation/pages/Login.dart';
import 'package:swine_care/feature/register/presentation/pages/Register.dart';
import 'package:swine_care/feature/settings/presentation/pages/Settings.dart';
import 'package:swine_care/feature/settings/presentation/widget/ChangePasswordPage.dart';
import 'package:swine_care/feature/settings/presentation/widget/NotificationsPage.dart';
import 'package:swine_care/feature/settings/presentation/widget/PrivacyPolicyPage.dart';
import 'package:swine_care/feature/settings/presentation/widget/SendFeedbackPage.dart';
import 'package:swine_care/feature/settings/presentation/widget/TermsAndConditionsPage.dart';

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
          builder: (context, state) {
            return const IntroPage();
          },
        ),
        GoRoute(
          path: '/loading-screen',
          builder: (context, state) {
            return const LoadingScreen();
          },
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) {
            return const Login();
          },
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) {
            return const Register();
          },
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            print('ScaffoldWithBottomNavBar Rebuilt for: ${navigationShell.currentIndex}');
            return ScaffoldWithBottomNavBar(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/homepage',
                  builder: (context, state) {
                    return const HomePage();
                  },
                  routes: [
                    GoRoute(
                      path: 'results',
                      builder: (context, state) {
                        final Map<String, dynamic> params = state.extra as Map<String, dynamic>? ?? {};
                        return ResultsPage(
                          uploadedImages: params['uploadedImages'] ?? {},
                          symptoms: params['symptoms'] ?? {},
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/guide',
                  builder: (context, state) {
                    return const GuidePage();
                  },
                  routes: [
                    GoRoute(
                      path: 'swine-farming',
                      builder: (context, state) {
                        return const SwineFarmingPage();
                      },
                    ),
                    GoRoute(
                      path: 'best-practices',
                      builder: (context, state) {
                        return const BestPracticesPage();
                      },
                    ),
                    GoRoute(
                      path: 'emergency-tips',
                      builder: (context, state) {
                        return const EmergencyMeasuresForDiseaseOutbreaks();
                      },
                    ),
                    GoRoute(
                      path: 'emergency',
                      builder: (context, state) {
                        return const EmergencyMeasuresPage();
                      },
                    ),
                    GoRoute(
                      path: 'preventing_asf',
                      builder: (context, state) {
                        return const PreventingAfricanSwineFever();
                      },
                    ),
                    GoRoute(
                      path: 'preventing',
                      builder: (context, state) {
                        return const PreventingAfricanSwineFeverPage();
                      },
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/history',
                  builder: (context, state) {
                    return const HistoryPage();
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/setting',
                  builder: (context, state) {
                    return const Settings();
                  },
                  routes: [
                    GoRoute(
                      path: 'notifications',
                      builder: (context, state) {
                        return const NotificationsPage();
                      },
                    ),
                    GoRoute(
                      path: 'change-password',
                      builder: (context, state) {
                        return const ChangePasswordPage();
                      },
                    ),
                    GoRoute(
                      path: 'privacy-policy',
                      builder: (context, state) {
                        return const PrivacyPolicyPage();
                      },
                    ),
                    GoRoute(
                      path: 'terms-conditions',
                      builder: (context, state) {
                        return const TermsAndConditionsPage();
                      },
                    ),
                    GoRoute(
                      path: 'send-feedback',
                      builder: (context, state) {
                        return const SendFeedbackPage();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}