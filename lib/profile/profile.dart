import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              const SizedBox(
                height: 250,
                width: double.infinity,
                child: Image(
                  image: AssetImage(
                    "assets/images/ent.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(15, 200, 15, 15),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(left: 95),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const <Widget>[
                                    Text(
                                      "Digit Kakushin Soft",
                                      //style: Theme.of(context).textTheme,
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.all(0),
                                      //You can add Subtitle here
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),

                            ],
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 80,
                          margin: const EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.15),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                              image: AssetImage(
                                "assets/images/ent.jpg",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: const <Widget>[
                          ListTile(
                            title: Text("User Informations"),
                          ),
                          Divider(),
                          ListTile(
                            title: Text("Email"),
                            subtitle: Text("username@dksoft.tn"),
                            leading: Icon(Icons.email),
                          ),
                          ListTile(
                            title: Text("Phone Number"),
                            subtitle:
                            Text("+216 12345678"),
                            leading: Icon(Icons.phone_in_talk_rounded),
                          ),
                          ListTile(
                            title: Text("Adresse"),
                            subtitle: Text(
                                "Sfax."),
                            leading: Icon(Icons.add_location_alt_rounded),
                          ),
                          ListTile(
                            title: Text("Joined Date"),
                            subtitle: Text("25 September 2020"),
                            leading: Icon(Icons.calendar_month_outlined),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
