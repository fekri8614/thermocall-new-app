import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thermocall_new2/view_models/controller/setup_controller.dart';

import '../../res/theme/app_colors.dart';
import '../../res/theme/text_styles.dart';

class DropDownItem {
  final String title;
  final Icon icon;

  DropDownItem({required this.title, required this.icon});

  static List<DropDownItem> dropDownItems = [
    DropDownItem(
      title: 'Share Code',
      icon: const Icon(Icons.ios_share),
    ),
    DropDownItem(
      title: 'Remove',
      icon: const Icon(Icons.remove_circle_outline),
    ),
  ];
}

class SetupWidgets {
  static AppBar setupAppBar(String title, void Function(String) onSelected,
      {bool centerTitle = true}) {
    return AppBar(
      title: Text(title),
      centerTitle: centerTitle,
      actions: [
        PopupMenuButton<DropDownItem>(
          iconColor: AppColors.accentColor,
          // surfaceTintColor: AppColors.accentColor,
          onSelected: (item) {
            // Handle the selection of an item
            onSelected(item.title);
          },
          itemBuilder: (context) => DropDownItem.dropDownItems.map((item) {
            return PopupMenuItem<DropDownItem>(
              value: item,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                textDirection: TextDirection.ltr,
                children: [
                  item.icon,
                  const SizedBox(width: 10),
                  Text(item.title),
                ],
              ),
            );
          }).toList(),
          icon: const Icon(Icons.more_vert),
        ),
      ],
    );
  }

  static Widget setupRangeSlider(
    BuildContext context,
    SetupController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Set Temperature Range"),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.06,
        ),
        Obx(
          () => Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      controller.rangeMinSlider.value.toString(),
                      style: AppTextStyle.blackNormalTextX16,
                    ),
                    if (controller
                            .sensorData.value.currentTemperature?.temperature !=
                        null)
                      controller.isTempOut(controller.sensorData.value)
                          ? Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.error,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(40),
                                ),
                              ),
                              width: 65,
                              height: 65,
                              child: Center(
                                child: Text(
                                  (controller.sensorData.value
                                              .currentTemperature?.temperature
                                              ?.toInt()) !=
                                          null
                                      ? controller.sensorData.value
                                          .currentTemperature!.temperature!
                                          .toInt()
                                          .toString()
                                      : "-0-",
                                  style: AppTextStyle.whiteNormalTextX22,
                                ),
                              ),
                            )
                          : Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withAlpha(20),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(40),
                                ),
                              ),
                              width: 65,
                              height: 65,
                              child: Center(
                                child: Text(
                                  (controller.sensorData.value
                                              .currentTemperature?.temperature
                                              ?.toInt()) !=
                                          null
                                      ? controller.sensorData.value
                                          .currentTemperature!.temperature!
                                          .toInt()
                                          .toString()
                                      : "-0-",
                                  style: AppTextStyle.blackBlueNormalTextX22,
                                ),
                              ),
                            ),
                    Text(
                      controller.rangeMaxSlider.value.toString(),
                      style: AppTextStyle.blackNormalTextX16,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                RangeSlider(
                  values: RangeValues(
                    controller.rangeMinSlider.value.toDouble(),
                    controller.rangeMaxSlider.value.toDouble(),
                  ),
                  min: -100.0,
                  max: 100.0,
                  divisions: 20,
                  labels: RangeLabels(
                    controller.rangeMinSlider.value.toString(),
                    controller.rangeMaxSlider.value.toString(),
                  ),
                  onChanged: (RangeValues values) {
                    controller.onRangeSliderValue(values);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
