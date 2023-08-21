import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//This is for define ButtonType of buttons List
enum ButtonType {
  facebook,
  google,
  twitter,
  linkedin,
  whatsapp,
  apple,
  github,
  yahoo,
  phone,
  email
}

//facebook Background Color
const Color facebookColor = Color(0xff39579A);
//twitter Background Color
const Color twitterColor = Color(0xff00ABEA);
//Whatsapp Background Color
const Color whatsappColor = Color(0xff075E54);
//Linkedin Background Color
const Color linkedinColor = Color(0xff0085E0);

//Github Background Color
const Color githubColor = Color(0xff202020);

//Apple Background Color
const Color appleColor = Color(0xff000000);

//Google Background Color
const Color googleColor = Color(0xffDF4A32);

//Phone Background Color
const Color yahooColor = Color(0xff773291);

//Phone Background Color
const Color phoneColor = Color(0xff455a64);

//Email Background Color
const Color emailColor = Color(0xff3F2F12);
class FlutterSocialButton extends StatelessWidget {
  final VoidCallback onTap;
  final ButtonType buttonType;
  final Color iconColor;
  final bool mini;
  final String? title;

  const FlutterSocialButton({
    Key? key,
    required this.onTap,
    this.buttonType = ButtonType.email,
    this.iconColor = Colors.white,
    this.mini = false,
    this.title,
  }) : super(key: key);

  // If we pass mini true its change button to small Circular button

  @override
  Widget build(BuildContext context) {
    switch (buttonType) {
      //Apple Button implementation
      case ButtonType.apple:
        return mini
            ? ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(), backgroundColor: appleColor,
                  padding: const EdgeInsets.all(20),
                ),
                child: Icon(
                  FontAwesomeIcons.apple,
                  color: iconColor,
                ),
              )
            : Container(
                padding: const EdgeInsets.all(20.0),
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onTap,
                  icon: Icon(
                    FontAwesomeIcons.apple,
                    color: iconColor,
                  ),
                  label: Text(title != null ? '$title' : 'Login With Apple'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20), backgroundColor: appleColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                ),
              );

    //Yahoo Button implementation
      case ButtonType.yahoo:
        return mini
            ? ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(), backgroundColor: yahooColor,
            padding: const EdgeInsets.all(20),
          ),
          child: Icon(
            FontAwesomeIcons.yahoo,
            color: iconColor,
          ),
        )
            : Container(
          padding: const EdgeInsets.all(20.0),
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onTap,
            icon: Icon(
              FontAwesomeIcons.yahoo,
              color: iconColor,
            ),
            label: Text(title != null ? '$title' : 'Login With Yahoo!'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(20), backgroundColor: yahooColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // <-- Radius
              ),
            ),
          ),
        );

      //Facebook Button implementation
      case ButtonType.facebook:
        return mini
            ? ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(), backgroundColor: facebookColor,
                  padding: const EdgeInsets.all(20),
                ),
                child: Icon(
                  FontAwesomeIcons.facebookF,
                  color: iconColor,
                ),
              )
            : Container(
                padding: const EdgeInsets.all(20.0),
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onTap,
                  icon: Icon(
                    FontAwesomeIcons.facebookF,
                    color: iconColor,
                  ),
                  label: Text(title != null ? '$title' : 'Login With Facebook'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20), backgroundColor: facebookColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                ),
              );

      //Google Button implementation
      case ButtonType.google:
        return mini
            ? ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(), backgroundColor: googleColor,
                  padding: const EdgeInsets.all(20),
                ),
                child: Icon(
                  FontAwesomeIcons.google,
                  color: iconColor,
                ),
              )
            : Container(
                padding: const EdgeInsets.all(20.0),
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onTap,
                  icon: Icon(
                    FontAwesomeIcons.google,
                    color: iconColor,
                  ),
                  label: Text(title != null ? '$title' : 'Login With Google'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20), backgroundColor: googleColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                ),
              );
      //Twitter Button implementation
      case ButtonType.twitter:
        return mini
            ? ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(), backgroundColor: twitterColor,
                  padding: const EdgeInsets.all(20),
                ),
                child: Icon(
                  FontAwesomeIcons.twitter,
                  color: iconColor,
                ),
              )
            : Container(
                padding: const EdgeInsets.all(20.0),
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onTap,
                  icon: Icon(
                    FontAwesomeIcons.twitter,
                    color: iconColor,
                  ),
                  label: Text(title != null ? '$title' : 'Login With Twitter'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20), backgroundColor: twitterColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                ),
              );

      //Linkedin Button implementation
      case ButtonType.linkedin:
        return mini
            ? ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(), backgroundColor: linkedinColor,
                  padding: const EdgeInsets.all(20),
                ),
                child: Icon(
                  FontAwesomeIcons.linkedin,
                  color: iconColor,
                ),
              )
            : Container(
                padding: const EdgeInsets.all(20.0),
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onTap,
                  icon: Icon(
                    FontAwesomeIcons.linkedin,
                    color: iconColor,
                  ),
                  label: Text(title != null ? '$title' : 'Login with Linkedin'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20), backgroundColor: linkedinColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                ),
              );
      //Whatsapp Button implementation
      case ButtonType.whatsapp:
        return mini
            ? ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(), backgroundColor: whatsappColor,
                  padding: const EdgeInsets.all(20),
                ),
                child: Icon(
                  FontAwesomeIcons.whatsapp,
                  color: iconColor,
                ),
              )
            : Container(
                padding: const EdgeInsets.all(20.0),
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onTap,
                  icon: Icon(
                    FontAwesomeIcons.whatsapp,
                    color: iconColor,
                  ),
                  label: Text(title != null ? '$title' : 'Login With Whatsapp'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20), backgroundColor: whatsappColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                ),
              );
      //GitHub Button implementation
      case ButtonType.github:
        return mini
            ? ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(), backgroundColor: phoneColor,
                  padding: const EdgeInsets.all(20),
                ),
                child: Icon(
                  FontAwesomeIcons.github,
                  color: iconColor,
                ),
              )
            : Container(
                padding: const EdgeInsets.all(20.0),
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onTap,
                  icon: Icon(
                    FontAwesomeIcons.github,
                    color: iconColor,
                  ),
                  label: Text(title != null ? '$title' : 'Login With Github'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20), backgroundColor: githubColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                ),
              );
      //Phone Button implementation
      case ButtonType.phone:
        return mini
            ? ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(), backgroundColor: phoneColor,
                  padding: const EdgeInsets.all(20),
                ),
                child: Icon(
                  Icons.phone_android,
                  color: iconColor,
                ),
              )
            : Container(
                padding: const EdgeInsets.all(20.0),
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onTap,
                  icon: Icon(
                    Icons.phone_android,
                    color: iconColor,
                  ),
                  label: Text(title != null ? '$title' : 'Login With Phone'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20), backgroundColor: phoneColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                ),
              );

      default:
        //Email Button implementation
        return mini
            ? ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(), backgroundColor: emailColor,
                  padding: const EdgeInsets.all(20),
                ),
                child: Icon(
                  Icons.email,
                  color: iconColor,
                ),
              )
            : Container(
                padding: const EdgeInsets.all(20.0),
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onTap,
                  icon: Icon(
                    Icons.email,
                    color: iconColor,
                  ),
                  label: Text(title != null ? '$title' : 'Login With Email'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20), backgroundColor: emailColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                ),
              );
    }
  }
}
