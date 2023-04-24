import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../constantes/image_strings.dart';
import '../../../../../constantes/text_string.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
            image: const AssetImage(tWelcomeScreenImage),
            height: size.height * 0.2),
      ],
    );
  }
}