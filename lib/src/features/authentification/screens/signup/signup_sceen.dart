import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestionConge/src/features/authentification/screens/signup/widgets/signup_footer_widget.dart';
import 'package:gestionConge/src/features/authentification/screens/signup/widgets/signup_form_widget.dart';


import '../../../../common_widget/form/form_header_widget.dart';
import '../../../../constantes/image_strings.dart';
import '../../../../constantes/sizes.dart';
import '../../../../constantes/text_string.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              children: const [
                FormHeaderWidget(
                  image: tWelcomeScreenImage,
                  title: tSignUpTitle,
                  subTitle: tSignUpSubTitle,
                  imageHeight: 0.50,
                ),
                SignUpFormWidget(),
                SignUpFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

