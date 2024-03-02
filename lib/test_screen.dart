import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/test_controller.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/view/screens/bch/branch_details_screen.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/gohome_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TestController());
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        children: [
          TopContainer(),
          const SizedBox(height: 20),
          CardWithCheckbox(
            title: 'البيانات الشخصية',
            onTapCard: () {},
            isDone: true,
            isActive: true,
          ),
          CardWithCheckbox(
            title: 'البيانات التجارية',
            onTapCard: () {},
            isDone: false,
            isActive: true,
          ),
          CardWithCheckbox(
            title: 'البيانات القانونية',
            onTapCard: () {},
            isDone: false,
            isActive: false,
          ),
          CardWithCheckbox(
            title: 'انشاء فرع',
            onTapCard: () {},
            isDone: false,
            isActive: false,
          ),
        ],
      ),
    )));
  }
}

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
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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

class TopContainer extends StatelessWidget {
  const TopContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double indicatorRadius = 60.w;
    return Container(
      height: Get.height * 0.25,
      width: Get.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color:
            AppColors.primaryColor, // Set the background color of the container
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Set the shadow color
            spreadRadius: 5, // Set the spread radius of the shadow
            blurRadius: 7, // Set the blur radius of the shadow
            offset: Offset(0, 3), // Set the offset of the shadow
          ),
        ],
      ),
      child: Stack(children: [
        Positioned.fill(
          child: CircularPercentIndicator(
            arcType: ArcType.FULL,
            startAngle: 240,
            radius: indicatorRadius,
            lineWidth: 10.w,
            percent: 1,
            progressColor: Color(0xFF737d74),
            backgroundColor: Color(0xFF6f7b6f),
            circularStrokeCap: CircularStrokeCap.round,
          ),
        ),
        Positioned.fill(
          child: CircularPercentIndicator(
            arcType: ArcType.FULL,
            curve: Curves.easeInOutCirc,
            startAngle: 240,
            animationDuration: 2000,
            animation: true,
            radius: indicatorRadius,
            lineWidth: 10,
            animateFromLastPercent: true,
            percent: 0.3,
            progressColor: Color(0xFFffc13d),
            backgroundColor: Color(0xFF6f7b6f),
            circularStrokeCap: CircularStrokeCap.round,
            center: NumberCountAnimation(
              endValue: 30,
              duration: Duration(seconds: 2),
            ),
          ),
        ),
      ]),
      // Other properties of the container...
    );
  }
}

class NumberCountAnimation extends StatefulWidget {
  final int endValue;
  final Duration duration;

  NumberCountAnimation(
      {required this.endValue, required this.duration, Key? key})
      : super(key: key);

  @override
  _NumberCountAnimationState createState() => _NumberCountAnimationState();
}

class _NumberCountAnimationState extends State<NumberCountAnimation> {
  late Key key; // Store a key to be used for rebuilding the animation

  @override
  void initState() {
    super.initState();
    key = UniqueKey(); // Generate a unique key for the initial build
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      key: key, // Use the key to force the rebuild
      tween: IntTween(begin: 0, end: widget.endValue),
      duration: widget.duration,
      builder: (context, int value, child) {
        return Text(
          "$value%",
          style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xFFfcfffa)),
          maxLines: 1,
        );
      },
    );
  }
}
