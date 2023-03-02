import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var value = "";
  var avatar = null;
  var name = null;
  var email = null;
  var company = null;
  var following = null;
  var followers = null;
  var location = null;

  // var avatar = null;
  Future apicall() async {
    final response =
        await http.get(Uri.parse("https://api.github.com/users/${value}"));
    final json = jsonDecode(response.body);
    print(response.body);
    setState(() {
      avatar = json['avatar_url'];
      name = json['name'];
      email = json['email'];
      company = json['company'];
      location = json['location'];
      following = json['following'];
      followers = json['followers'];
      // 'avatar_url'
      // avatar = json['profile_pic_url_hd'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
            child: Scaffold(
                body: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: ListView(
                      children: [
                        Column(children: [
                          RichText(
                            text: TextSpan(
                              style:
                                  TextStyle(color: Colors.black, fontSize: 32),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Get ',
                                    style: TextStyle(color: Colors.blue)),
                                TextSpan(text: 'GitHub'),
                                TextSpan(
                                  text: ' Profile',
                                  style: TextStyle(color: Colors.blue),
                                )
                              ],
                            ),
                            textScaleFactor: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 50,
                                width: 280,
                                child: TextField(
                                  onChanged: (text) {
                                    print(text);
                                    value = text;
                                  },
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      hintText: "Enter User Name",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(width: 20))),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15)))),
                                    onPressed: () {
                                      apicall();
                                    },
                                    child: Icon(
                                      Icons.search,
                                    )),
                              ),
                            ],
                          ),
                          Center(
                            child: SizedBox(
                              height: 568,
                              width: 400,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  if (avatar != null) ...[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Container(
                                            height: 150,
                                            width: 150,
                                            child: Image.network(avatar),
                                            // child: CircleAvatar(
                                            //   backgroundImage: NetworkImage(avatar),
                                            // ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey.shade600,
                                                    spreadRadius: 1,
                                                    blurRadius: 15)
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.lightBlue.shade400,
                                                  Colors.purple.shade300,
                                                ],
                                              )),
                                          height: 340,
                                          width: 350,
                                          // color: Colors.blue,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Name : ${name}",
                                                  style:
                                                      TextStyle(fontSize: 22),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text("Email : ${email}",
                                                    style: TextStyle(
                                                        fontSize: 22)),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text("Company : ${company}",
                                                    style: TextStyle(
                                                        fontSize: 22)),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text("Following : ${following}",
                                                    style: TextStyle(
                                                        fontSize: 22)),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text("Follower : ${followers}",
                                                    style: TextStyle(
                                                        fontSize: 22)),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text("Location : ${location}",
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        fontSize: 22)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          )
                        ]),
                      ],
                    )))));
  }
}
