import 'dart:developer';

import 'package:backdrop_modal_route/backdrop_modal_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:line_icons/line_icons.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:unicrush/model/user_model.dart';
import 'package:unicrush/presentation/configs/configs.dart';
import 'package:unicrush/presentation/configs/constant_assets.dart';
import 'package:unicrush/presentation/views/find/find_page_controller.dart';
import 'dart:ui';
import 'package:unicrush/presentation/widgets/profile_tiles.dart';
import 'package:unicrush/services/current_user_data_service.dart';

class FindPage extends StatelessWidget {
  FindPage({super.key});
  final FindPageController controller = Get.put(FindPageController());
  final TextEditingController searchControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FindPageController>(
      builder: (_) => Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: kBackground,
        body: SingleChildScrollView(
          child: SizedBox(
            height: Get.height,
            child: Stack(
              children: [
                //background image
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Image.asset(
                    kaBackground,
                    fit: BoxFit.cover,
                  ),
                ),

                // searchBox
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: _topBar(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _topBar(BuildContext context) {
    return Column(
      children: [
        Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.transparent,
                  border: Border.all(color: kBackground)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: kBackground.withOpacity(0.2),
                    ),
                    child: Row(
                      children: [
                        _searchBar(context),
                        const Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: Text(
                            'Find your crush',
                            style: TextStyle(
                                fontFamily: ksFontFamily,
                                fontSize: 20,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  SearchBarAnimation _searchBar(BuildContext context) {
    return SearchBarAnimation(
      durationInMilliSeconds: 500,
      onPressButton: (isOpen) {
        controller.searchController.clear();
        searchControl.clear();
        FocusScope.of(context).unfocus();
        controller.resetSearch();
      },
      enableKeyboardFocus: true,
      buttonElevation: 2,
      isOriginalAnimation: false,
      buttonBorderColour: Colors.purpleAccent,
      onFieldSubmitted: (String value) {
        handleCustomizedBackdropContent(context);
        controller.filteredValues(value);
      },
      textEditingController: searchControl,
      trailingWidget: const Icon(
        Icons.search,
        color: Colors.purpleAccent,
      ),
      secondaryButtonWidget: const Icon(
        Icons.arrow_back_ios_new_rounded,
        color: Colors.purpleAccent,
      ),
      buttonWidget: const Icon(
        IconlyLight.search,
        color: Colors.purpleAccent,
      ),
    );
  }

  Widget _searchBody() {
    return Column(
      children: [
        Align(
            alignment: Alignment.topRight,
            child: Transform.rotate(
              angle: 45 * (3.14 / 180), // Convert degrees to radians
              child: CustomIconButtons(
                icon: LineIcons.plus,
                onTap: () => Get.back(),
              ),
            )),
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            'Club: ${CurrentUserDataService().userModel!.clubs}',
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: _searchListBody(),
        ),
      ],
    );
  }

  void handleCustomizedBackdropContent(BuildContext context) async {
    await Navigator.push(
      context,
      BackdropModalRoute<void>(
        overlayContentBuilder: (context) {
          return _searchBody();
        },
        topPadding: 100.0,
        barrierColorVal: Colors.transparent,
        backgroundColor: kBlack12.withOpacity(0.5),
        backdropShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        // barrierLabelVal: 'Customized Backdrop',
        shouldMaintainState: false,
        canBarrierDismiss: true,
      ),
    );
  }

  Widget _searchListBody() {
    return controller.searchList.isEmpty
        ? Column(
            children: [
              Center(
                child: Text(
                  'User Not Found',
                  style: TextStyle(
                      fontFamily: ksFontFamily,
                      fontSize: 15,
                      color: kBackground),
                ),
              ),
              Center(
                child: Text(
                  'Want to invite ?',
                  style: TextStyle(
                      fontFamily: ksFontFamily,
                      fontSize: 15,
                      color: kBackground),
                ),
              ),
              Center(
                  child: TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(kBackground)),
                onPressed: () => log('invite'),
                child: Text('Invite'.toUpperCase()),
              )),
            ],
          )
        : SizedBox(
            height: Get.height * 0.8,
            child: ListView.builder(
              itemCount: controller.searchList.length,
              itemBuilder: (context, index) {
                UserModel user = controller.searchList[index];
                return ListTile(
                  leading: CircleAvatar(
                    foregroundImage: NetworkImage(user.photos.toString()),
                  ),
                  title: Text(user.username),
                  subtitle: Text(user.email ?? ''),
                  // You can add more details as needed
                  onTap: () => profileDetailsBottomSheet(context, user),
                );
              },
            ),
          );
  }
}
