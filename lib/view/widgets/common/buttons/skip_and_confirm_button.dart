import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';

class SaveAndSkipButton extends StatelessWidget {
  final String confirmText;
  final String skipText;
  final Function() confirmOnTap;
  final Function()? skipOnTap;
  const SaveAndSkipButton({
    super.key,
    this.confirmText = 'حفظ',
    this.skipText = 'تخطي',
    required this.confirmOnTap,
    this.skipOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: SizedBox(
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: MaterialButton(
                    color: AppColors.secondaryColor,
                    textColor: Colors.white,
                    onPressed: confirmOnTap,
                    child: AutoSizeText('حفظ',
                        maxLines: 1,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                )),
          ),
          const SizedBox(width: 10),
          skipOnTap != null
              ? Expanded(
                  flex: 1,
                  child: SizedBox(
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: MaterialButton(
                          color: AppColors.gray300,
                          textColor: AppColors.secondaryColor,
                          onPressed: skipOnTap,
                          child: AutoSizeText('تخطى',
                              maxLines: 1,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      )),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
