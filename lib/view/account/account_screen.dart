import 'package:flutter/material.dart';

import '../../res/theme/app_colors.dart';
import '../../res/theme/text_styles.dart';
import 'account_widget.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.accentColor, width: 2),
          borderRadius: const BorderRadius.all(
            Radius.circular(22),
          ),
        ),
        width: MediaQuery.of(context).size.width * 0.8,
        child: MaterialButton(
          padding: const EdgeInsets.all(12),
          textColor: AppColors.accentColor,
          onPressed: () {
            //
          },
          child: const Text(
            "Edit Profile",
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AccountWidgets.accountItem(context),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.01,
                  ),
                  width: double.maxFinite,
                  height: 2,
                  color: AppColors.blackBlue.withAlpha(30),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Device Owner",
                        style: AppTextStyle.blackNormalTextX16,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      const Text(
                        "Device Observer",
                        style: AppTextStyle.blackNormalTextX16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
