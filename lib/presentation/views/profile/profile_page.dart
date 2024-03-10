import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicrush/model/lists.dart';
import 'package:unicrush/presentation/configs/configs.dart';
import 'package:unicrush/presentation/views/profile/profile_page_controller.dart';
import 'package:unicrush/presentation/widgets/custom_text_field.dart';
import 'package:unicrush/services/current_user_data_service.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final ProfilePageController controller = Get.put(ProfilePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: SizedBox(
                  height: Get.height / 6,
                  width: Get.height / 6,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      CurrentUserDataService().userModel!.photos.toString(),
                    ),
                  ),
                ),
              ),
              Text(
                CurrentUserDataService().userModel!.username,
                style: textStyleSubTitle,
              ),
              CustomTextField(
                controller: controller.universityController,
                label: 'University',
                keyboardType: TextInputType.name,
                hint: 'Enter your university name',
              ),
              CustomTextField(
                controller: controller.clubController,
                label: 'Club Name',
                keyboardType: TextInputType.name,
                hint: 'Enter your club name',
              ),
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white)),
                onPressed: controller.saveProfile,
                child: const Text('Save'),
              ),
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white)),
                onPressed: controller.onTapLogOut,
                child: const Text('LogOut'),
              ),
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white)),
                onPressed: () {
                  fetchUsers();
                },
                child: const Text('Test'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
