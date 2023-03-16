import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
 final TextEditingController controller;
 final Widget? widget;
  const MyInputField({Key? key, required this.title, required this.hint, required this.controller, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          Container(
            height: 52,
            padding: const EdgeInsets.only(left: 14),
            margin: const EdgeInsets.only(top: 8.0),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: Colors.grey
              ),
              borderRadius: BorderRadius.circular(12)
            ),
            child: Row(
              children:[
                Expanded(
                  child:TextFormField(
                    readOnly: widget==null?false:true,
                    autofocus: false,
                    cursorColor: Get.isDarkMode?Colors.grey[100]:Colors.grey[700],
                    controller: controller,
                    style: subTitleStyle,
                    decoration: InputDecoration(
                      hintText:hint,
                      hintStyle: subTitleStyle,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: context.theme.backgroundColor,
                          width: 0,
                        )
                      ),
                      enabledBorder:UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: context.theme.backgroundColor,
                            width: 0,
                          )
                      ),
                    ),
                  ) ,
                ),
                widget==null?Container():Container(child: widget,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
