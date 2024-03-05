import 'package:flutter/material.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/data/models/payment_method.dart';

class CustomRadioButton extends StatefulWidget {
  const CustomRadioButton({super.key});

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  List<PaymentMethod> paymentMethods = [
    PaymentMethod(id: 1, title: 'كاش'),
    PaymentMethod(id: 2, title: 'تقسيط'),
    PaymentMethod(id: 3, title: 'فيزا'),
  ];
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: paymentMethods.length,
        shrinkWrap: true,
        itemBuilder: ((context, index) => RadioButtonItem(
              title: paymentMethods[index].title!,
              onTap: () {
                setState(() {
                  selectedIndex = index;
                  print(selectedIndex);
                });
              },
              isSelected: index == selectedIndex,
            )));
  }
}

class RadioButtonItem extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final bool isSelected;

  RadioButtonItem({
    required this.title,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.secondaryColor
              : AppColors.secondaryColor95,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            if (isSelected)
              Icon(
                Icons.done,
                color: Colors.white,
                size: 20,
              )
            else
              SizedBox(width: 20),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color:
                      isSelected ? AppColors.white : AppColors.secondaryColor25,
                ),
              ),
            ),
            const SizedBox(width: 30),
          ],
        ),
      ),
    );
  }
}
