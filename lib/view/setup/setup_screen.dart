// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thermocall_new2/models/sensor/single_sensor.dart';
import 'package:thermocall_new2/models/sensor/update_sensor.dart';
import 'package:thermocall_new2/view_models/controller/setup_controller.dart';

import '../../res/components/const_widgets.dart';
import '../../res/components/general_exception.dart';
import '../../res/components/internet_exceptions_widget.dart';
import '../../res/theme/app_colors.dart';
import '../../res/theme/text_styles.dart';
import '../../utils/app_utils.dart';
import 'setup_widgets.dart';

class SetupScreen extends StatelessWidget {
  final String sensorId;

  SetupScreen({
    super.key,
    required this.sensorId,
  }) {
    Get.lazyPut(() => SetupController(sensorId: sensorId));
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SetupController>();

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: OutlinedButton(
          onPressed: () {
            controller.updateSensor(
              sensorId,
              UpdateSensor(
                label: controller.sensorLabel.value,
                min: controller.rangeMinSlider.value.toString(),
                max: controller.rangeMaxSlider.value.toString(),
              ),
            );
          },
          child: const Text("Save"),
        ),
      ),
      appBar: SetupWidgets.setupAppBar(
        'Setup',
        (value) {
          if (value == DropDownItem.dropDownItems[0].title) {
            // TODO: handle sharing sensor
          } else {
            // remove sensor
            controller.deleteSensor(sensorId);
            Navigator.pop(context);
          }
        },
      ),
      body: FutureBuilder<SingleSensor>(
        future: controller.getSingleSensor(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ConstWidgets.waitingScreen();
          } else if (snapshot.hasError) {
            if (snapshot.error.toString() == 'No internet') {
              return InterNetExceptionWidget(
                onPress: () {
                  controller.refreshApi();
                },
              );
            } else {
              return GeneralExceptionWidget(
                onPress: () {
                  controller.refreshApi();
                },
              );
            }
          } else if (snapshot.hasData) {
            // Instead of rebuilding everything, notify controller to update data
            controller.updateSensorData(snapshot.data!);
            return _buildBody(context, controller);
          } else {
            print("Unexpected error -> ${snapshot.data}");
            return const Center(child: Text('Unexpected error.'));
          }
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, SetupController controller) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "ID: ",
                      style: AppTextStyle.blackBoldTitleX16,
                    ),
                    Text(controller.sensorData.value.sensorId),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Updated: ",
                      style: AppTextStyle.blackBoldTitleX16,
                    ),
                    Text(
                      "${AppUtils.convertToNowIranTime(controller.sensorData.value.currentTemperature!.timestamp.toUtc().toIso8601String())} ago",
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Container(
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                onChanged: (value) {
                  controller.sensorLabel.value = value;
                },
                controller: controller.edtControllerID,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Label',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  hintText: "Bio Cell",
                  hintStyle: TextStyle(
                    color: AppColors.blackBlue.withAlpha(40),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            SetupWidgets.setupRangeSlider(context, controller),
          ],
        ),
      ),
    );
  }
}
