// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thermocall_new2/res/components/const_widgets.dart';
import 'package:thermocall_new2/utils/app_utils.dart';
import '../../models/sensor/create_sensor.dart';
import '../../models/sensor/show_sensor.dart';
import '../../res/components/general_exception.dart';
import '../../res/components/internet_exceptions_widget.dart';
import '../../view_models/controller/dashboard_controller.dart';
import '../setup/setup_screen.dart';
import 'dasboard_widgets.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key}) {
    Get.lazyPut(() => DashboardController());
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();

    return Scaffold(
      appBar: DashboardWidgets.dashAppBar(
        'Dashboard',
        (value) {
          // TODO: show something
        },
      ),
      body: FutureBuilder<List<ShowSensor>>(
        future: controller.sensorListApi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ConstWidgets.waitingScreen();
          } else if (snapshot.hasError) {
            // Handle different error scenarios based on the error message
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
            controller.sensorList(snapshot.data);
            if (controller.sensorList.isEmpty) {
              return const Center(child: Text('No sensors available.'));
            }
            return _buildBody(controller.sensorList, context, controller);
          } else {
            return const Center(child: Text('Unexpected error.'));
          }
        },
      ),
      floatingActionButton: DashboardWidgets.dashFABIcon(() {
        DashboardWidgets.showCreateSensorDataDialog(
          context,
          title: "Add a new Device",
          edtIDController: controller.edtControllerID,
          edtLabelController: controller.edtControllerLabel,
          edtMinController: controller.edtControllerMinTemp,
          edtMaxController: controller.edtControllerMaxTemp,
          onSavePressed: () {
            String? sensorID = controller.edtControllerID.text;
            String? sensorLabel = controller.edtControllerLabel.text;
            String? sensorMin = controller.edtControllerMinTemp.text;
            String? sensorMax = controller.edtControllerMaxTemp.text;
            if ((sensorID.isNotEmpty || sensorID != null) &&
                (sensorLabel.isNotEmpty || sensorLabel != null) &&
                (sensorMin.isNotEmpty || sensorMin != null) &&
                (sensorMax.isNotEmpty || sensorMax != null)) {
              controller.createNewSensor(
                CreateSensor(
                  sensorId: controller.edtControllerID.text,
                  label: controller.edtControllerLabel.text,
                  min: controller.edtControllerMinTemp.text,
                  max: controller.edtControllerMaxTemp.text,
                ),
              );
            } else {
              AppUtils.snackBar('ERROR', 'Check your input, then try again!');
            }
          },
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildBody(
    List<ShowSensor> sensorList,
    BuildContext context,
    DashboardController controller,
  ) {
    return Obx(
      () => SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: sensorList.map((sensor) {
              return DashboardWidgets.sensorItem(
                context,
                sensor,
                controller,
                () {
                  // onItemPressed
                  Get.to(SetupScreen(sensorId: sensor.id))?.then((_) {
                    controller.refreshApi();
                  });
                  controller.refreshApi();
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
