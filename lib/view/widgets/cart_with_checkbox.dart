import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';

class CardWithCheckbox extends StatelessWidget {
  final String title;
  final Function() onTapCard;
  final bool isDone;
  final bool isActive;
  const CardWithCheckbox(
      {super.key,
      required this.title,
      required this.onTapCard,
      required this.isDone,
      required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: isActive ? AppColors.gray : AppColors.gray.withOpacity(0.6),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isActive ? onTapCard : null,
            child: Container(
              height: 60.h,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDone ? Colors.green : null,
                        border: isDone
                            ? null
                            : Border.all(
                                width: 0.7, color: Colors.grey.shade400)),
                    child: Icon(
                      Icons.done,
                      color: isDone ? Colors.white : Colors.transparent,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                      child: AutoSizeText(
                    title,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                      color: isActive
                          ? Colors.grey.shade700
                          : Colors.grey.shade400,
                    ),
                  )),
                  Icon(
                    Icons.arrow_forward,
                    color:
                        isActive ? Colors.grey.shade500 : Colors.grey.shade300,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CardSimple extends StatelessWidget {
  final String title;
  final Function() onTapCard;

  const CardSimple({
    super.key,
    required this.title,
    required this.onTapCard,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.gray,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTapCard,
            child: Container(
              height: 60.h,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  Expanded(
                      child: AutoSizeText(
                    title,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                      color: Colors.grey.shade700,
                    ),
                  )),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.grey.shade500,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
