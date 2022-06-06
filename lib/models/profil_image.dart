import 'dart:io';
import 'package:confit/models/user_controller.dart';
import 'package:confit/themes/colors.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';

import '../Screens/screens.dart';

class ProfilImage extends StatelessWidget {
  const ProfilImage({
    Key? key,
    required File? image,
    required this.showInAppBar,
  })  : _image = image,
        super(key: key);

  final File? _image;
  final bool showInAppBar;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: showInAppBar ? 15.0 : 30,
      backgroundColor: showInAppBar ? AppColors.background : AppColors.button,
      child: ClipOval(
        child: (_image != null)
            ? Image.file(_image!)
            : Image.asset(
                'assets/images/profile_Image_unknown.png',
                fit: BoxFit.fill,
              ),
      ),
    );
  }
}

class ProfilImageInAppBar extends StatefulWidget {
  const ProfilImageInAppBar({Key? key}) : super(key: key);

  @override
  State<ProfilImageInAppBar> createState() => _ProfilImageInAppBarState();
}

class _ProfilImageInAppBarState extends State<ProfilImageInAppBar> {
  @override
  Widget build(BuildContext context) {
    Controller c = Get.find();
    return Ink(
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => SimpleDialog(
              title: const Text(
                'Menü',
                style: TextStyle(color: AppColors.text),
              ),
              backgroundColor: AppColors.cardColor,
              children: <Widget>[
                SimpleDialogOption(
                  child: const Text(
                    'Profil bearbeiten',
                    style: TextStyle(color: AppColors.text),
                  ),
                  onPressed: () {
                    setState(() {
                      Get.to(() => const BasedataScreen());
                    });

                    //Navigator.pop(context);
                  },
                ),
                SimpleDialogOption(
                  child: const Text(
                    'Abmelden',
                    style: TextStyle(color: AppColors.text),
                  ),
                  onPressed: () {
                    setState(() {
                      Get.to(() => const LoginScreen());
                    });
                  },
                ),
                SimpleDialogOption(
                  child: const Text(
                    'Abbrechen',
                    style: TextStyle(color: AppColors.text),
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                )
              ],
            ),
          );
        },
        child: ProfilImage(
          image: c.user.value.image,
          showInAppBar: true,
        ),
      ),
    );
  }
}
