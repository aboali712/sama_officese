import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(children: [    Container(
          width: 407,
          height: 407,
        ),
          Container(
            width: 407,
            height: 407,
          )],),
        Stack(children: [    Container(
            width: 375,
            height: 812,
            decoration:     BoxDecoration(
                color: Colors.white)
        ),
          Image.asset(
            "assets/Ellipse 98.png",
            width: 245,
            height: 245,
          ),
          Image.asset(
            "assets/Ellipse 100.png",
            width: 245,
            height: 245,
          ),
          Container(
            width: 377,
            height: 377,
          )],),
        Column(
          children: [
            Stack(children: [],),
            Stack(children: [    Stack(children: [    Container(
              width: 22,
              height: 11.333333015441895,
            ),
              Container(
                width: 1.328037977218628,
                height: 4,
              ),
              Container(
                width: 18,
                height: 7.333333492279053,
              )],),

            ],),
            Stack(children: [    Container(
              width: 28.42616844177246,
              height: 11.0888671875,
            )],)
          ],
        ),
        Column(
          children: [
            Container(
                width: 134,
                height: 5,
                decoration:     BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color(0xfff2f2f2))
            )
          ],
        ),
        Stack(children: [    Column(
          children: [

          ],
        ),
          Stack(children: [    Row(
            children: [
              Text(
                  "Log In",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )
              )
            ],
          ),
            Text(
                "First time here? Sign up",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                )
            ),
            Text(
                "Forgot Password?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                )
            ),
            Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                )
            ),
            Text(
                "Log in to your account using email or social networks",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                )
            ),
            Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          "assets/Squircle (Stroke).png",
                          width: 21.81818199157715,
                          height: 20,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                            "Email",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            )
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [

                      ],
                    ),
                    Row(
                      children: [
                        Text(
                            "",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            )
                        ),

                      ],
                    )
                  ],
                )
              ],
            )],),
          Stack(children: [    Stack(children: [    Text(
              "Or sign in with ",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              )
          ),
            Container(
                width: 109,
                height: 1,
                decoration:     BoxDecoration(
                    color: Color(0x99d8d8d8))
            ),
            Container(
                width: 109,
                height: 1,
                decoration:     BoxDecoration(
                    color: Color(0x99d8d8d8))
            )],),
            Column(
              children: [
                Text(
                    "Google",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    )
                ),
                Column(
                  children: [
                    Stack(children: [    Container(
                      width: 8.823750495910645,
                      height: 8.635746002197266,
                    ),
                      Container(
                        width: 14.296815872192383,
                        height: 7.445042610168457,
                      ),
                      Container(
                        width: 4.048396587371826,
                        height: 8.255556106567383,
                      ),
                      Container(
                        width: 14.363662719726562,
                        height: 7.445040225982666,
                      )],)
                  ],
                )
              ],
            ),
            Column(
              children: [
                Text(
                    "Facebook",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    )
                ),
                Column(
                  children: [
                    Image.asset(
                      "assets/bg.png",
                      width: 24,
                      height: 24,
                    ),
                    Image.asset(
                      "assets/facebook.png",
                      width: 12,
                      height: 12,
                    )
                  ],
                )
              ],
            )],)],),
        Image.asset(
          "assets/Слой 3 1.png",
          width: 75,
          height: 84.43567657470703,
        ),
        Row(
          children: [
            Column(
              children: [
             
              ],
            ),
            Row(
              children: [
                Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    )
                ),
                Column(
                  children: [

                  ],
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
