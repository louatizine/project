import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../constantes/sizes.dart';
import '../../../../../constantes/text_string.dart';
import '../../../../../../Service/logincontroller.dart';
import '../../../../core/controllers/registercontrollers.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Registerontroller registercontroller =
    Get.put(Registerontroller());



    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  label: Text(tFullName),
                  prefixIcon: Icon(Icons.person_outline_rounded),
                  border: OutlineInputBorder(),
              ),
              controller: registercontroller.UsernameController,
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
                decoration: const InputDecoration(
                  label: Text(tEmail), prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
              controller: registercontroller.emailController,
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              decoration: const InputDecoration(
                  label: Text(tRole), prefixIcon: Icon(Icons.numbers),
                border: OutlineInputBorder(),
              ),
              controller: registercontroller.roleController,

            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              decoration: const InputDecoration(
                  label: Text(tPassword), prefixIcon: Icon(Icons.fingerprint), border: OutlineInputBorder(),
              ),
              controller: registercontroller.passwordController,
            ),
            const SizedBox(height: tFormHeight - 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => registercontroller.registerWithEmail(),
                child: Text(tSignup.toUpperCase()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
