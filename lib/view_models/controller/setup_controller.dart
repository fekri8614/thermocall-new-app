import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thermocall_new2/models/sensor/current_temperature.dart';
import 'package:thermocall_new2/models/sensor/single_sensor.dart';
import 'package:thermocall_new2/models/sensor/update_sensor.dart';
import 'package:thermocall_new2/repository/setup/setup_repository.dart';

class SetupController extends GetxController {
  final String sensorId;
  SetupController({required this.sensorId});
  final _api = SetupRepository();

  RxBool showDropDown = false.obs;
  var error = ''.obs;

  RxInt rangeMinSlider = 0.obs;
  RxInt rangeMaxSlider = 0.obs;

  RxString sensorLabel = ''.obs;

  var sensorData = SingleSensor(
    sensorId: '',
    label: '',
    min: '',
    max: '',
    currentTemperature: CurrentTemperature(
      temperature: 0,
      timestamp: DateTime.now(),
    ),
  ).obs;

  late final TextEditingController edtControllerID;
  late final FocusNode focusNode;

  void onDropDownMenuClicked() {
    showDropDown.value = !showDropDown.value;
  }

  void onRangeSliderValue(RangeValues values) {
    rangeMinSlider.value = values.start.toInt();
    rangeMaxSlider.value = values.end.toInt();
  }

  bool isTempOut(SingleSensor data) {
    final temperature = data.currentTemperature?.temperature;

    final maxTemp = int.tryParse(data.max);
    final minTemp = int.tryParse(data.min);

    if (temperature != null && maxTemp != null && minTemp != null) {
      return temperature > maxTemp || temperature < minTemp;
    }

    return false;
  }

  Future<SingleSensor> getSingleSensor() async {
    try {
      final sensor = await _api.getSingleSensor(sensorId);
      updateSensorData(sensor);
      return sensor;
    } catch (e) {
      error.value = e.toString();
      rethrow;
    }
  }

  void updateSensorData(SingleSensor sensor) {
    sensorData.value = sensor;
    sensorLabel.value = sensor.label;
    edtControllerID.text = sensorLabel.value;
    rangeMinSlider(int.parse(sensor.min));
    rangeMaxSlider(int.parse(sensor.max));
  }

  Future<void> updateSensor(String sensorId, UpdateSensor sensor) async {
    try {
      await _api.updateSensorData(sensorId, sensor);
      await refreshApi();
    } catch (e) {
      error.value = e.toString();
      rethrow;
    }
  }

  Future<void> deleteSensor(String sensorId) async {
    try {
      await _api.deleteSensor(sensorId);
    } catch (e) {
      error.value = e.toString();
      rethrow;
    }
  }

  Future<void> refreshApi() => getSingleSensor();

  @override
  void onInit() {
    super.onInit();
    edtControllerID = TextEditingController();
    focusNode = FocusNode();
    getSingleSensor();
  }
}
