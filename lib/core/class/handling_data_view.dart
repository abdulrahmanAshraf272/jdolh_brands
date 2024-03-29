import 'package:flutter/material.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:lottie/lottie.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;

  const HandlingDataView(
      {super.key, required this.statusRequest, required this.widget});

  //TODO replace the text with Lottie animation.
  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? const Center(child: CircularProgressIndicator())
        : statusRequest == StatusRequest.offlineFailure
            ? Center(child: Lottie.asset('assets/icons/noInternetIcon.json'))
            : statusRequest == StatusRequest.serverFailure
                ? const Center(child: Text('server failure'))
                : statusRequest == StatusRequest.failure
                    ? const Center(child: Text('لا توجد نتائج'))
                    : statusRequest == StatusRequest.unableToGetLocation
                        ? const Center(
                            child: Text('غير قارد للوصول لمكانك الحالي'))
                        : widget;
  }
}

class HandlingDataRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;

  const HandlingDataRequest(
      {super.key, required this.statusRequest, required this.widget});

  //TODO replace the text with Lottie animation.
  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? const Center(child: CircularProgressIndicator())
        : statusRequest == StatusRequest.offlineFailure
            ? Center(child: Lottie.asset('assets/icons/noInternetIcon.json'))
            : statusRequest == StatusRequest.serverFailure
                ? const Center(child: Text('server failure'))
                : widget;
  }
}
