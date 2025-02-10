import 'package:go_router/go_router.dart';
import 'package:swine_care/feature/guide/presentation/pages/GuidePage.dart';
import 'package:swine_care/feature/guide/presentation/pages/SwineFarmingPage.dart';
import 'package:swine_care/feature/guide/presentation/widgets/GuidePageWidgets/EmergencyTips.dart';
import 'package:swine_care/feature/guide/presentation/widgets/GuidePageWidgets/PreventingAfricanSwineFever.dart';
import 'package:swine_care/feature/homepage/presentation/pages/HomePage.dart';
import 'package:swine_care/feature/intro/presentation/pages/IntroPage.dart';
import 'package:swine_care/feature/loadingscreen/presentation/pages/LoadingScreen.dart';
import 'package:swine_care/feature/login/presentation/pages/Login.dart';
import 'package:swine_care/feature/register/presentation/pages/Register.dart';
import 'package:swine_care/feature/settings/presentation/pages/Settings.dart';

class RouterConfiguration {
  GoRouter routes() {
    return GoRouter(
      // redirect: (context, state) =>, RESERVE CODE FOR REDIRECTION INCASE IF USER IS LOGGED IN YOU CAN TRANSFER THEM TO LOGIN OR MAIN SCREEN
      initialLocation: '/intro',
      routes: [
        GoRoute(path: '/intro',
        builder: (context, state) => const IntroPage()
        ),
        GoRoute(
          path: '/loading-screen',
          builder: (context, state) =>  const Loadingscreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) =>  const Login(),
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) =>  const Register(),
        ),
        GoRoute(
          path: '/homepage',
          builder: (context, state) =>  const HomePage(),
        ),
        GoRoute(
          path: '/guide',
          builder: (context, state) =>  const GuidePage(),
        ),
        GoRoute(
          path: '/setting',
          builder: (context, state) =>  const Settings(),
        ),
        GoRoute(path: '/swine-farming',
        builder: (context, state) => const SwineFarmingPage()
        ),
        GoRoute(path: '/emergency-tips',
            builder: (context, state) => const EmergencyMeasuresForDiseaseOutbreaks()
        ),
        GoRoute(path: '/preventing_asf',
            builder: (context, state) => const TipsToAvoidSickPigs()
        ),

      ],
    );
  }
}

