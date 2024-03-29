import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/data/models/payment_method.dart';

class CustomMultiSelect extends StatefulWidget {
  const CustomMultiSelect({
    super.key,
  });

  @override
  State<CustomMultiSelect> createState() => _CustomMultiSelectState();
}

class _CustomMultiSelectState extends State<CustomMultiSelect> {
  List<PaymentMethod> paymentMethods = [
    PaymentMethod(id: 1, title: 'كاش'),
    PaymentMethod(id: 2, title: 'تقسيط'),
    PaymentMethod(id: 3, title: 'فيزا'),
  ];

  List<int> selectedPaymentMethods = [];

  addRemovePaymentMethods(int index) {
    if (selectedPaymentMethods.contains(paymentMethods[index].id!)) {
      removePaymentMethod(index);
    } else {
      addPaymentMethod(index);
    }
  }

  addPaymentMethod(int index) {
    selectedPaymentMethods.add(paymentMethods[index].id!);
    print(selectedPaymentMethods);
  }

  removePaymentMethod(int index) {
    selectedPaymentMethods.remove(paymentMethods[index].id!);
    print(selectedPaymentMethods);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: paymentMethods.length,
        shrinkWrap: true,
        itemBuilder: ((context, index) => MultiSelectItem(
              title: paymentMethods[index].title!,
              onTap: () {
                addRemovePaymentMethods(index);
              },
            )));
  }
}

class MultiSelectItem extends StatefulWidget {
  final String title;
  final String? sutitle;
  final void Function() onTap;
  final bool initActiveState;
  final double fontSize;
  final bool isClickable;
  const MultiSelectItem(
      {super.key,
      required this.onTap,
      required this.title,
      this.initActiveState = false,
      this.sutitle,
      this.fontSize = 12,
      this.isClickable = true});

  @override
  State<MultiSelectItem> createState() => _MultiSelectItemState();
}

class _MultiSelectItemState extends State<MultiSelectItem> {
  bool active = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    active = widget.initActiveState;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: active ? AppColors.secondaryColor : AppColors.secondaryColor95,
          borderRadius: BorderRadius.circular(30)),
      child: InkWell(
        onTap: widget.isClickable
            ? () {
                setState(() {
                  active = !active;
                });
                widget.onTap();
              }
            : null,
        child: Row(
          children: [
            active
                ? Icon(
                    Icons.done,
                    color: Colors.white,
                    size: 20,
                  )
                : SizedBox(width: 20),
            Spacer(),
            Column(
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                    fontSize: widget.fontSize.sp,
                    color:
                        active ? AppColors.white : AppColors.secondaryColor25,
                  ),
                ),
                widget.sutitle != null
                    ? Text(
                        widget.sutitle!,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w600,
                          fontSize: 9.sp,
                          color: active
                              ? AppColors.white
                              : AppColors.secondaryColor25,
                        ),
                      )
                    : SizedBox()
              ],
            ),
            Spacer(),
            const SizedBox(width: 20)
          ],
        ),
      ),
    );
  }
}
