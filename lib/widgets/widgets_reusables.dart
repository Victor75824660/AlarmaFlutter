import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:flutter_golang_yt/services/validator.dart';
import 'package:flutter_golang_yt/colors/colors2.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_golang_yt/screens/signin.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

TextFormField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller, validator, maxLength) {
  return TextFormField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Campo Requerido';
      }
    },
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white70,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    onChanged: (String value) {},
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container signInsignUpButton(
    BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        isLogin ? 'Iniciar Sesión' : 'Registrarse',
        style: const TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return Colors.white;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        hexStringToColor("CB2B93"),
        hexStringToColor("9546C4"),
        hexStringToColor("5E61F4")
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: AnimatedSplashScreen(
        splash: Lottie.asset('assets/aaa.json'),
        backgroundColor: Color(0xFFC11DF3),
        nextScreen: SignIn(),
        splashIconSize: 250,
        duration: 3000,
        splashTransition: SplashTransition.sizeTransition,
        pageTransitionType: PageTransitionType.topToBottom,
        animationDuration: const Duration(seconds: 1),
      ),
    );
  }
}

class SnackError extends StatelessWidget {
  const SnackError({
    Key? key,
    required this.errorText,
  }) : super(key: key);
  final String errorText;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
            padding: const EdgeInsets.all(16),
            height: 80,
            decoration: const BoxDecoration(
                color: const Color(0xFFC72C41),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "Error",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          Center(
                            child: Text(
                              errorText,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
        Positioned(
            bottom: 0,
            child: ClipRRect(
                borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
            ))),
      ],
    );
  }
}
