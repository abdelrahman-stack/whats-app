import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whats_app_clone/core/extension/custom_theme_extension.dart';
import 'package:whats_app_clone/core/helper/show_alert_dialog.dart';
import 'package:whats_app_clone/core/models/user_model.dart';
import 'package:whats_app_clone/core/services/supabase_storage_service.dart';
import 'package:whats_app_clone/core/utils/app_colors.dart';
import 'package:whats_app_clone/core/widgets/custom_elevated_button.dart';
import 'package:whats_app_clone/core/widgets/custom_icon_button.dart';
import 'package:whats_app_clone/feature/auth/views/home_view.dart';
import 'package:whats_app_clone/feature/auth/views/image_picker_view.dart';
import 'package:whats_app_clone/feature/auth/views/widgets/custom_text_form_field.dart';

class UserInfoView extends StatefulWidget {
  const UserInfoView({super.key});

  static const String routeName = 'userInfoView';

  @override
  State<UserInfoView> createState() => _UserInfoViewState();
}

class _UserInfoViewState extends State<UserInfoView> {
  File? imageCamera;
  String? imageUrl;
  Uint8List? imageGallery;
  final storage = SupabaseStorageService();
  final nameController = TextEditingController();

  Future<void> pickImageFromGallery() async {
    Navigator.pop(context);
    final image = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ImagePickerView()),
    );
    if (image == null) return;

    setState(() {
      imageGallery = image;
      imageCamera = null;
    });

    final url = await storage.uploadBytes(
      bucket: 'profiles',
      bytes: imageGallery!,
      userId: "USER_ID_HERE",
      fileExtension: "jpg",
    );

    if (url != null) {
      setState(() => imageUrl = url);
    }
  }

  Future<void> imageFromCamera() async {
    Navigator.pop(context);
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      setState(() {
        imageCamera = File(image!.path);
        imageGallery = null;
      });
      final url = await storage.uploadFile(
        bucket: 'profiles',
        file: imageCamera!,
        userId: '',
      );
      if (url != null) {
        setState(() {
          imageUrl = url;
        });
      }
    } catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }

  imagePickerIcon({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        CustomIconButton(
          icon: icon,
          onPressed: onTap,
          iconColor: AppColors.greenDrak,
          minWidth: 50,
          border: Border.all(
            color: context.theme.grayColor!.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        SizedBox(height: 5),
        Text(text, style: TextStyle(color: context.theme.grayColor)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Profile Info',
          style: TextStyle(color: context.theme.authAppBarTextColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'please provide your name and an optional profile photo',
                  style: TextStyle(color: context.theme.grayColor),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 20),
                            const Text(
                              'Profile photo',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            CustomIconButton(
                              icon: Icons.close,
                              onPressed: () => Navigator.pop(context),
                            ),
                            const SizedBox(width: 15),
                          ],
                        ),
                        Divider(
                          color: context.theme.grayColor!.withValues(
                            alpha: 0.3,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const SizedBox(width: 20),
                            imagePickerIcon(
                              text: 'Camera',
                              icon: Icons.camera_alt_outlined,
                              onTap: imageFromCamera,
                            ),
                            const SizedBox(width: 15),
                            imagePickerIcon(
                              text: 'Gallery',
                              icon: Icons.photo_camera_back_rounded,
                              onTap: pickImageFromGallery,
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                      ],
                    );
                  },
                ),
                child: Container(
                  padding: const EdgeInsets.all(26),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.theme.photoIconBackgroundColor,
                    border: Border.all(
                      color: imageCamera == null && imageGallery == null
                          ? Colors.transparent
                          : context.theme.grayColor!.withValues(alpha: 0.4),
                    ),
                    image: imageGallery != null
                        ? DecorationImage(
                            image: MemoryImage(imageGallery!),
                            fit: BoxFit.cover,
                          )
                        : imageCamera != null
                        ? DecorationImage(
                            image: FileImage(imageCamera!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 3, bottom: 3),
                    child: Icon(
                      Icons.add_a_photo_rounded,
                      color: imageCamera == null && imageGallery == null
                          ? context.theme.photoIconColor
                          : Colors.transparent,
                      size: 48,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  const SizedBox(width: 20),
                  Expanded(
                    child: CustomTextFormField(
                      controller: nameController,
                      hintText: 'Type your name here',
                      textAlign: TextAlign.left,
                      autofocus: true,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.emoji_emotions_outlined,
                    color: context.theme.photoIconColor,
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButton(
        text: 'NEXT',
        onPressed: () async {
          final name = nameController.text.trim();

          if (name.isEmpty) {
            showAlertDialog(
              context: context,
              message: "Please enter your name",
            );
            return;
          }

          final user = FirebaseAuth.instance.currentUser;
          if (user == null) {
            showAlertDialog(context: context, message: "No user logged in");
            return;
          }

          try {
            final storage = SupabaseStorageService();
            String? imageUrl;

            if (imageCamera != null) {
              imageUrl = await storage.uploadFile(
                bucket: "profiles",

                file: imageCamera!,
                userId: user.uid,
              );
            } else if (imageGallery != null) {
              imageUrl = await storage.uploadBytes(
                bucket: "profiles",
                bytes: imageGallery!,
                userId: user.uid,
                fileExtension: "jpg",
              );
            }

            imageUrl ??= "https://your-default-image.png";

            final newUser = UserModel(
              id: user.uid,
              name: name,
              phoneNumber: user.phoneNumber ?? '',
              groupId: [],
              photoUrl: imageUrl,
              isOnline: true,
            );

            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .set(newUser.toMap());

            Navigator.pushReplacementNamed(context, HomeView.routeName);
          } catch (e) {
            showAlertDialog(context: context, message: e.toString());
          }
        },

        buttonWidth: 90,
      ),
    );
  }
}
