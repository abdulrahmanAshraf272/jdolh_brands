import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/bch/bch_manager_controller.dart';
import 'package:jdolh_brands/controller/categories_controller.dart';
import 'package:jdolh_brands/core/class/handling_data_view.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/strings.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/view/widgets/bch_manager/no_bch_manager_found.dart';
import 'package:jdolh_brands/view/widgets/common/appBarWithButtonCreate.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/custom_toggle_general.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_brands/view/widgets/common/custom_appbar.dart';

class BchManagerScreen extends StatelessWidget {
  const BchManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BchManagerController());

    return GetBuilder<BchManagerController>(
        builder: (controller) => Scaffold(
            appBar: customAppBar(title: 'مدير الفرع'),
            // floatingActionButton: controller.bchManager == null
            //     ? GoHomeButton(
            //         onTap: () {}, text: 'إضافة', height: 40, width: 100)
            //     : null,
            // floatingActionButtonLocation:
            //     FloatingActionButtonLocation.centerFloat,
            body: HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: controller.bchManager == null
                  ? NoBchManagerFound(
                      onTapAddManager: () => controller.onTapAddBchManager(),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              controller.name,
                              style: headline2,
                            ),
                            const SizedBox(height: 10),
                            controller.justCreated
                                ? UserNameAndPasswordCardJustCreated(
                                    username: controller.username,
                                    password: controller.password,
                                    enable: controller
                                        .bchManager!.bchmanagerIsActive!,
                                    onTapEnable: () =>
                                        controller.onTapSwitchEnable(),
                                    onTapDelete: () => controller.onTapDelete(),
                                    onTapSend: () =>
                                        controller.sendUserNameAndPassword())
                                : UserNameAndPasswordCard(
                                    username: controller.username,
                                    password: controller.password,
                                    enable: controller
                                        .bchManager!.bchmanagerIsActive!,
                                    onTapDisplayPassword: () =>
                                        controller.passwordUnableToShowDialog(),
                                    onTapEnable: () =>
                                        controller.onTapSwitchEnable(),
                                    onTapDelete: () =>
                                        controller.onTapDelete()),
                            const SizedBox(height: 20),
                            Text(
                              managerComment,
                              style: titleSmallGray,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              textAlign: TextAlign.center,
                              managerWarning,
                              style: titleSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
            )));
  }
}

class UserNameAndPasswordCardJustCreated extends StatelessWidget {
  final String username;
  final String password;
  final int enable;
  final void Function() onTapEnable;
  final void Function() onTapDelete;
  final void Function() onTapSend;
  const UserNameAndPasswordCardJustCreated(
      {super.key,
      required this.username,
      required this.password,
      required this.enable,
      required this.onTapEnable,
      required this.onTapDelete,
      required this.onTapSend});

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: Get.height * 0.25,
      width: Get.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.white, // Set the background color of the container
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Set the shadow color
            spreadRadius: 5, // Set the spread radius of the shadow
            blurRadius: 7, // Set the blur radius of the shadow
            offset: const Offset(0, 3), // Set the offset of the shadow
          ),
        ],
      ),
      child: Column(
        children: [
          UsernameText(
            title: ' اسم المستخدم:  ',
            value: username,
            enble: enable,
          ),
          PasswordText(
            title: ' كلمة السر:  ',
            value: password,
            enble: enable,
            justCreated: true,
            onTapDiplayPassword: null,
          ),
          const SizedBox(height: 20),
          SendUserNameAndPassword(
            onTapSend: onTapSend,
          ),
          const SizedBox(height: 20),
          EnableBchManager(
              enable: enable,
              onTapEnable: onTapEnable,
              title: 'ايقاف موقت للمدير'),
          TextButton(
              onPressed: onTapDelete,
              child: Text(
                'حذف',
                style: titleSmall.copyWith(color: Colors.red),
              ))
        ],
      ),
      // Other properties of the container...
    );
  }
}

class UserNameAndPasswordCard extends StatelessWidget {
  final String username;
  final String password;
  final int enable;
  final void Function() onTapEnable;
  final void Function() onTapDelete;
  final void Function() onTapDisplayPassword;
  const UserNameAndPasswordCard({
    super.key,
    required this.username,
    required this.password,
    required this.enable,
    required this.onTapEnable,
    required this.onTapDelete,
    required this.onTapDisplayPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: Get.height * 0.25,
      width: Get.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.white, // Set the background color of the container
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Set the shadow color
            spreadRadius: 5, // Set the spread radius of the shadow
            blurRadius: 7, // Set the blur radius of the shadow
            offset: const Offset(0, 3), // Set the offset of the shadow
          ),
        ],
      ),
      child: Column(
        children: [
          UsernameText(
            title: ' اسم المستخدم:  ',
            value: username,
            enble: enable,
          ),
          const SizedBox(height: 20),
          PasswordText(
            title: ' كلمة السر:  ',
            value: '••••••••••',
            enble: enable,
            justCreated: false,
            onTapDiplayPassword: onTapDisplayPassword,
          ),
          const SizedBox(height: 20),
          EnableBchManager(
              enable: enable,
              onTapEnable: onTapEnable,
              title: 'ايقاف موقت للمدير'),
          TextButton(
              onPressed: onTapDelete,
              child: Text(
                'حذف',
                style: titleSmall.copyWith(color: Colors.red),
              ))
        ],
      ),
      // Other properties of the container...
    );
  }
}

class SendUserNameAndPassword extends StatelessWidget {
  final void Function() onTapSend;
  const SendUserNameAndPassword({
    super.key,
    required this.onTapSend,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
            textAlign: TextAlign.center,
            'يجب عليك ارسال اسم المستخدم وكلمة السر للمدير الان لأنها ستكون مشفره بعد ذلك لأسباب امنية.'),
        const SizedBox(height: 10),
        CustomButton(
          onTap: onTapSend,
          text: '  ارسال  ',
          size: 1.2,
        ),
      ],
    );
  }
}

class EnableBchManager extends StatefulWidget {
  final int enable;
  final void Function() onTapEnable;
  final String title;
  const EnableBchManager(
      {super.key,
      required this.enable,
      required this.onTapEnable,
      required this.title});

  @override
  State<EnableBchManager> createState() => _EnableBchManagerState();
}

class _EnableBchManagerState extends State<EnableBchManager> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.gray,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              setState(() {
                widget.onTapEnable();
              });
            },
            child: Container(
              //width: 80.w,
              padding: const EdgeInsets.only(left: 10),
              height: 35.h,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    margin: const EdgeInsets.all(8.5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.enable == 0 ? Colors.green : null,
                        border: widget.enable == 0
                            ? null
                            : Border.all(
                                width: 0.7, color: Colors.grey.shade400)),
                    child: Icon(
                      Icons.done,
                      color: widget.enable == 0
                          ? Colors.white
                          : Colors.transparent,
                      size: 12,
                    ),
                  ),
                  Text(
                    widget.title,
                    maxLines: 1,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  const SizedBox(width: 6)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordText extends StatelessWidget {
  final String title;
  final String value;
  final int enble;
  final bool justCreated;
  final void Function()? onTapDiplayPassword;
  const PasswordText(
      {super.key,
      required this.title,
      required this.value,
      required this.enble,
      required this.justCreated,
      this.onTapDiplayPassword});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: titleMedium,
        ),
        Expanded(
          child: AutoSizeText(
            value,
            maxLines: 1,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: AppColors.textDark,
                decoration: enble == 0 ? TextDecoration.lineThrough : null),
          ),
        ),
        const SizedBox(width: 5),
        IconButton(
            onPressed: onTapDiplayPassword,
            icon: justCreated
                ? Icon(Icons.visibility)
                : Icon(Icons.visibility_off))
      ],
    );
  }
}

class UsernameText extends StatelessWidget {
  final String title;
  final String value;
  final int enble;

  const UsernameText({
    super.key,
    required this.title,
    required this.value,
    required this.enble,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: titleMedium,
        ),
        Expanded(
          child: AutoSizeText(
            value,
            maxLines: 1,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: AppColors.textDark,
                decoration: enble == 0 ? TextDecoration.lineThrough : null),
          ),
        ),
      ],
    );
  }
}

class ListIsEmptyText extends StatelessWidget {
  const ListIsEmptyText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                  text: 'اضف الاصناف التي سوف تعرض في القائمة\n',
                  style: TextStyle(
                      color: AppColors.black.withOpacity(0.7),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo'),
                ),
                TextSpan(
                    text: 'مثال: مشويات , وجبات',
                    style: TextStyle(
                        color: AppColors.black.withOpacity(0.4),
                        fontSize: 14,
                        fontFamily: 'Cairo'))
              ])),
        ],
      ),
    );
  }
}
