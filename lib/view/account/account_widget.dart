import 'package:flutter/material.dart';

import '../../res/app_urls/app_urls.dart';
import '../../res/theme/text_styles.dart';

class AccountWidgets {
  static Widget accountItem(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(
        children: [
          ClipOval(
            child: Image.asset(
              AppUrls.personImage,
              width: MediaQuery.of(context).size.width * 0.24,
              height: MediaQuery.of(context).size.width * 0.24,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.04,
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hamid Askari",
                style: AppTextStyle.blackNormalTextX22,
              ),
              Text(
                "Label Technician",
                style: AppTextStyle.blackNormalTextX14,
              ),
              Text(
                "hamid.askari@gmail.com",
                style: AppTextStyle.blackNormalTextX14,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
