import 'package:app_lokdon/Api/A_login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences prefs;
  late String user;
  late String pass;

  Future<void> _logOut(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Apa kamu yakin?'),
        content: const Text('Ingin keluar dari Aplikasi'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              prefs.clear();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login', (Route<dynamic> route) => false);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  Widget profilView() {
    return Container(
      padding: const EdgeInsets.only(left: 30, bottom: 20),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(blurRadius: 2, color: Colors.black, spreadRadius: 1)
              ],
            ),
            child: const CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 30,
              child: CircleAvatar(
                backgroundImage: AssetImage("asset/images/user.ico"),
                radius: 250,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'wildan husnain',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 18, 18, 18),
                  ),
                ),
                Text(
                  '11020138231028391',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color.fromARGB(255, 17, 16, 16),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    Future<bool> _onWillPop() async {
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes'),
            ),
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        //appbar
        appBar: AppBar(
          //setting appbar
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          //setting appbar

          //isi appbar
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(55.0), child: profilView()),

          actions: [
            IconButton(
                onPressed: () => _logOut(context),
                icon: const Icon(Icons.exit_to_app,
                    color: Color.fromARGB(255, 22, 86, 236))),
          ],

          //isi appbar
        ),
        //appbar

        //bodi
        body: SingleChildScrollView(
          child: Column(
            children: const [],
          ),
        ),
        //bodi
      ),
    );
  }
}
