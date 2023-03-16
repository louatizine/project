import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestionConge/home/home.dart';
import 'package:get/get.dart';

import '../../../../constantes/sizes.dart';
import '../../../../constantes/text_string.dart';
import '../../../core/controllers/logincontroller.dart';
import '../../../core/controllers/registercontrollers.dart';
import '../forget_password/forget_password_option/forgot_password_model_bottom_sheet.dart';
import 'login_screen.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Registerontroller registercontroller =
    Get.put(Registerontroller());

    LoginController loginController = Get.put(LoginController());
    var isLogin = false.obs;
    return Form(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_outlined),
                  labelText: tEmail,
                  hintText: tEmail,
                  border: OutlineInputBorder()),
              controller: registercontroller.emailController,
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.fingerprint),
                labelText: tPassword,
                hintText: tPassword,
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: null,
                  icon: Icon(Icons.remove_red_eye_sharp),
                ),
              ),
              controller: registercontroller.passwordController,

            ),
            const SizedBox(height: tFormHeight - 20),


            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                ForgetPasswordScreen.buildShowModalBottomSheet(context);
                },
                  child: const Text(tForgetPassword),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.to(() =>const Home()),
                child: Text(tLogin.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}