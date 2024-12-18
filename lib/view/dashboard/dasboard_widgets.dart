import 'package:flutter/material.dart';
import 'package:thermocall_new2/models/sensor/show_sensor.dart';
import 'package:thermocall_new2/utils/app_utils.dart';
import 'package:thermocall_new2/view_models/controller/dashboard_controller.dart';
import '../../res/theme/app_colors.dart';
import '../../res/theme/text_styles.dart';

class DropDownItem {
  final String title;
  final Icon icon;

  DropDownItem({required this.title, required this.icon});

  static List<DropDownItem> items = [
    DropDownItem(
      title: 'Celcius',
      icon: const Icon(Icons.abc),
    ),
    DropDownItem(
      title: 'Report Issue',
      icon: const Icon(Icons.mode_edit),
    ),
  ];
}

class DashboardWidgets {
  static Future<void> showCreateSensorDataDialog(
    BuildContext context, {
    String title = '',
    required TextEditingController edtIDController,
    required TextEditingController edtLabelController,
    required TextEditingController edtMinController,
    required TextEditingController edtMaxController,
    required final void Function() onSavePressed,
  }) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          title: Center(
            child: Text(
              title,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                onSavePressed();
                Navigator.pop(context);
              },
              textColor: AppColors.accentColor,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Save"),
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Cancel"),
              ),
            ),
          ],
          content: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: edtIDController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'ID',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  hintText: "eg: Th12345678",
                  hintStyle: TextStyle(
                    color: AppColors.blackBlue.withAlpha(40),
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.006,
              ),
              TextFormField(
                controller: edtLabelController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Label',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  hintText: "eg: Room3-Lab",
                  hintStyle: TextStyle(
                    color: AppColors.blackBlue.withAlpha(40),
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.006,
              ),
              TextFormField(
                controller: edtMinController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Min',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  hintText: "-2",
                  hintStyle: TextStyle(
                    color: AppColors.blackBlue.withAlpha(40),
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.006,
              ),
              TextFormField(
                controller: edtMaxController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Max',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  hintText: "-4",
                  hintStyle: TextStyle(
                    color: AppColors.blackBlue.withAlpha(40),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static AppBar dashAppBar(String title, void Function(String) onMenuPressed,
      {bool centerTitle = true}) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title),
      centerTitle: centerTitle,
      actions: [
        PopupMenuButton<DropDownItem>(
          iconColor: AppColors.accentColor,
          // surfaceTintColor: AppColors.accentColor,
          onSelected: (item) {
            // Handle the selection of an item
            onMenuPressed(item.title);
          },
          itemBuilder: (context) => DropDownItem.items.map((item) {
            return PopupMenuItem<DropDownItem>(
              value: item,
              child: Row(
                textDirection: TextDirection.ltr,
                mainAxisAlignment: MainAxisAlignment.start,
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

  static FloatingActionButton dashFABIcon(void Function() onAddSensorPressed) {
    return FloatingActionButton(
      backgroundColor: AppColors.accentColor,
      onPressed: onAddSensorPressed,
      shape: const CircleBorder(),
      child: const Icon(Icons.add_outlined),
    );
  }

  static Widget sensorItem(BuildContext context, ShowSensor data,
      DashboardController controller, Function() onItemPressed) {
    controller.playError(controller.isTempOut(data));
    return Container(
      margin: const EdgeInsets.all(8),
      width: MediaQuery.sizeOf(context).width * 0.9,
      height: 120,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withAlpha(20),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: InkWell(
        onTap: onItemPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.label,
                    style: AppTextStyle.blackBlueNormalTextX24,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  if (data.currentTemperature != null)
                    Text(
                      (data.currentTemperature?.timestamp) != null
                          ? "Last update at ${AppUtils.convertToIranTime(data.currentTemperature!.timestamp.toUtc().toIso8601String())}"
                          : "-0-",
                      style: AppTextStyle.blackNormalTextX14,
                    ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.min.toString(),
                    style: AppTextStyle.blackNormalTextX16,
                  ),
                  if (data.currentTemperature != null)
                    controller.isTempOut(data)
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
                                (data.currentTemperature?.temperature) != null
                                    ? data.currentTemperature!.temperature!
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
                                (data.currentTemperature?.temperature) != null
                                    ? data.currentTemperature!.temperature!
                                        .toInt()
                                        .toString()
                                    : "-0-",
                                style: AppTextStyle.blackBlueNormalTextX22,
                              ),
                            ),
                          ),
                  Text(
                    data.max.toString(),
                    style: AppTextStyle.blackNormalTextX16,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
