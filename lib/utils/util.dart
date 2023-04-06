import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_app_bloc/utils/image_assets.dart';
import 'package:intl/intl.dart';
import '../presentation/widgets/veg_indicator_widget.dart';
import '../presentation/widgets/yellow_btn_widget.dart';
import 'colors.dart';
import 'text_styles.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackbar({
  required BuildContext context,
  required String title,
  Duration duration = const Duration(milliseconds: 2000),
  SnackBarAction? action,
}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(title),
      duration: duration,
      behavior: SnackBarBehavior.floating,
      action: action,
    ),
  );
}

//2023-01-05T00: 00: 00.000Z to 05 Jan, 2023
String dateTimeTZToDateStringFormat(String dateTime) {
  DateTime tempDate = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(dateTime);
  return DateFormat('dd MMM, yyyy').format(tempDate);
}

String convert24hrToTimeString(String time) {
  return DateFormat("hh:mm a").format(DateFormat.Hm().parse(time));
}

//2022-12-22 18:45 to 22 Dec 2022
String dateTimeToDateStringFormat(String dateTime) {
  DateTime tempDate =
      DateFormat("yyyy-MM-dd HH:mm").parse(dateTime); //2022-12-22 18:45
  return DateFormat('dd MMM yyyy').format(tempDate);
}

//2022-12-22 18:45 to 6:45 PM
String dateTimeToTimeStringFormat(String dateTime) {
  DateTime tempDate = DateFormat("yyyy-MM-dd HH:mm").parse(dateTime);
  return DateFormat('hh:mm a').format(tempDate);
}

//3:00 PM to 15:00
String timeStringTo24HourFormat(String time) =>
    DateFormat("HH:mm").format(DateFormat.jm().parse(time));

//yyyy-MM-dd
String dateFormatter(DateTime dateTime) {
  final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
  return dateFormatter.format(dateTime);
}

//HH:mm
String timeFormatter(DateTime dateTime) {
  final DateFormat timeFormatter = DateFormat('HH:mm');
  return timeFormatter.format(dateTime);
}

//15:00 to 3:00 PM
String timeFormatterAmPm(String time) {
  return DateFormat.jm().format(DateFormat("HH:mm").parse(time));
}

//yyyy-MM-dd HH:mm'
String dateTimeFormatter(DateTime dateTime) {
  final DateFormat dateTimeFormatter = DateFormat('yyyy-MM-dd HH:mm');
  return dateTimeFormatter.format(dateTime);
}

Future<String> getDeviceType() async {
  return Platform.isAndroid
      ? "Android"
      : Platform.isIOS
          ? "iOS"
          : "";
}

void dismissKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

Future<dynamic> showChangeLocationDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (c) {
      return SimpleDialog(
        contentPadding: const EdgeInsets.all(25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              changeLocationIcon,
              const SizedBox(height: 18),
              const Text(
                'JRoute not available at this location please select a different location',
                maxLines: 3,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Montserrat-Medium',
                ),
              ),
              const SizedBox(height: 28),
              GestureDetector(
                onTap: () {
                  Navigator.of(c).pop();
                },
                child: const YellowButtonWidget(
                  text: 'Change Location',
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ],
      );
    },
  );
}

Future<dynamic> showCustomizeBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(22),
      ),
    ),
    builder: (ctx) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(22),
          ),
        ),
        child: Column(
          children: [
            DecoratedBox(
              decoration: const BoxDecoration(
                color: kScaffoldBackgroundColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(22),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 18,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Awadhi Veg Biryani',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(ctx);
                          },
                          child: const Icon(
                            Icons.close_rounded,
                            color: kLightTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 0),
                ],
              ),
            ),
            Expanded(
              child: Scrollbar(
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 12,
                          ),
                          child: Text(
                            "Quantity",
                            style: mediumBoldTextStyle.copyWith(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 15,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  VegIndicatorWidget(isVeg: true),
                                  SizedBox(width: 9),
                                  Text(
                                    'Half',
                                    style: TextStyle(
                                      color: kBlackTextColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: const [
                                  Text(
                                    'SAR 120',
                                    style: TextStyle(
                                      color: kAccentColor,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.radio_button_checked_rounded,
                                    color: kAccentColor,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 15,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  VegIndicatorWidget(isVeg: true),
                                  SizedBox(width: 9),
                                  Text(
                                    'Half',
                                    style: TextStyle(
                                      color: kBlackTextColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: const [
                                  Text(
                                    'SAR 120',
                                    style: TextStyle(
                                      color: kAccentColor,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.radio_button_checked_rounded,
                                    color: kAccentColor,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 80,
              padding: const EdgeInsets.only(
                bottom: 20,
                left: 20,
                right: 20,
              ),
              color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SAR 120',
                        style: mediumBoldTextStyle.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const Text(
                        '1 item',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      print('view cart');
                    },
                    child: Text(
                      'Add item to cart',
                      style: mediumBoldTextStyle.copyWith(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    },
  );
}
