import 'package:app_lokdon/Api/A_login.dart';
import 'package:app_lokdon/View/home.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late ProgressDialog pr;
  String pesan = '';
  String nama = '';
  late String user;
  late String pass;
  late SharedPreferences prefs;

//proses sessions
  @override
  void initState() {
    super.initState();
  }

  saveSession(
    String user,
  ) async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('user', user);
      prefs.setBool('login', true);
    });
  }

  dalletSession(
    String user,
  ) async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.remove(user);
    });
  }
//proses sessions

//proses login
  void prosesLogin(String user, String pass) async {
    pr.show();
    setState(() {
      ApiLogin.login(user, pass).then((value) {
        if (value.response == 1) {
          pr.hide();
          saveSession(user);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const HomeScreen();
          }));
        } else {
          pr.hide();
          dalletSession(user);
          pesan = value.pesan;
          AlertDialog alert2 = AlertDialog(
            title: const Text("Warning !!"),
            content: Text(pesan),
          );
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert2;
            },
          );
        }
      });
    });
  }
//proses login

//proses reset
  reset() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.remove("user");
      pesan = '';
      userNameController.clear();
      passwordController.clear();
    });
  }
//proses reset

  @override
  Widget build(BuildContext context) {
    //loding
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.normal,
      textDirection: TextDirection.rtl,
    );

    pr.style(
      //message: 'Downloading file...',
      //widgetAboveTheDialog: const Text('meow'),
      message: 'Please wait...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      progressWidgetAlignment: Alignment.center,
      maxProgress: 10.0,
      progressTextStyle: const TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: const TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
    //loding

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            //header
            Container(
              decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.only(bottomLeft: Radius.circular(100)),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      const Color.fromARGB(255, 86, 163, 227),
                      Colors.blue.shade700,
                    ],
                  )),
              width: double.infinity,
              height: 350,
              child: Image.asset("asset/images/logo_lokdon_new.png"),
            ),
            //header

            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  //form input
                  TextFormField(
                      controller: userNameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(20.0),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        labelText: 'Username',
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0),
                      )),
                  const SizedBox(height: 20.0),
                  TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(20.0),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0),
                      )),
                  //form input
                  const SizedBox(height: 20.0),
                  //Tombol
                  SizedBox(
                    width: 260,
                    height: 40,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                        onPressed: () async {
                          if (userNameController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            //tampil dialog pesan
                            AlertDialog alert = const AlertDialog(
                              title: Text("Warning !!"),
                              content: Text("Masukkan Username dan Password!"),
                            );
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                            //tampil dialog pesan
                          } else {
                            prosesLogin(userNameController.text,
                                passwordController.text);
                          }
                        },
                        child: const Text("LOGIN")),
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    width: 260,
                    height: 40,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                        onPressed: reset,
                        child: const Text("RESET")),
                  ),

                  //Tombol
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
