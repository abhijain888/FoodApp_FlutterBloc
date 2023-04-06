import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/svg/location.svg'),
                    const SizedBox(width: 10),
                    const LimitedBox(
                      maxWidth: 180,
                      child: Text(
                        "Sector 63, Noida",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SvgPicture.asset('assets/svg/downarrow.svg'),
                  ],
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffE2E6ED)),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Row(
                children: [
                  SvgPicture.asset('assets/svg/language.svg'),
                  const SizedBox(width: 5),
                  const Text(
                    'English',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
