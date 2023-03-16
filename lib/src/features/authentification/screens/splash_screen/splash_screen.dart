import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gestionConge/src/features/authentification/screens/welcome/welcome_screen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value){
      Navigator.of(context).pushReplacement(CupertinoDialogRoute(builder: (ctx)=> const WelcomeScreen(), context: context));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(image:AssetImage("assets/images/homescreen.png"), width: 300,
            ),
            SizedBox(height: 50,),
            SpinKitThreeBounce(
              color: Colors.blue,
              size: 50.0,
            )

          ],
        ),
      ),
    );
  }
}
