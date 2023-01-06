import 'package:app_lokdon/View/home.dart';
import 'package:app_lokdon/View/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

//membuat halaman splash
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreenView(
        navigateRoute: const SessionClass(),
        duration: 4000,
        imageSize: 130,
        imageSrc: "asset/images/logo_lokdon_new.png",
        backgroundColor: Colors.white,
      ),
    );
  }
}

///proses penentian sesion
class SessionClass extends StatefulWidget {
  const SessionClass({super.key});

  @override
  State<SessionClass> createState() => _SessionClassState();
}

class _SessionClassState extends State<SessionClass> {
  @override
  void initState() {
    checkSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<void> checkSession() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool login = preferences.getBool('login') ?? false;
    if (login) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const FormLogin()));
    }
  }
}
 ///proses penentian sesion
