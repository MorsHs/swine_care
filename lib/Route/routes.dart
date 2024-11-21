import 'package:go_router/go_router.dart';
import 'package:swine_care/feature/loadingscreen/presentation/pages/LoadingScreen.dart';
import 'package:swine_care/feature/login/presentation/pages/Login.dart';
import 'package:swine_care/feature/register/presentation/pages/Register.dart';

class RouterConfiguration {
  GoRouter routes() {
    return GoRouter(
      // redirect: (context, state) =>, RESERVE CODE FOR REDIRECTION INCASE IF USER IS LOGGED IN YOU CAN TRANSFER THEM TO LOGIN OR MAIN SCREEN
      initialLocation: '/loading-screen',
      routes: [
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
        )

      ],
    );
  }
}

