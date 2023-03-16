import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import '../../../../../constantes/sizes.dart';
import '../../../../../constantes/text_string.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(tDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              tOtpTitle,
              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 80.0),
            ),
            Text(tOtpSubTitle.toUpperCase(), style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 40.0),
            const Text("$tOtpMessage ur mail adresse", textAlign: TextAlign.center),
            const SizedBox(height: 20.0),
            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 80,
              style: const TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) {
                print("Completed: $pin");
              },
            ),

            const SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () {}, child: const Text(tNext)),
            ),
          ],
        ),
      ),
    );
  }
}