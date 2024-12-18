import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:thermocall_new2/models/sensor/create_sensor.dart';
import 'package:thermocall_new2/res/app_urls/app_urls.dart';
import '../../models/sensor/show_sensor.dart';
import '../../repository/dashboard/dashboard_repository.dart';

class DashboardController extends GetxController {
  final _api = DashboardRepository();

  var sensorList = <ShowSensor>[].obs;
  var error = ''.obs;

  // controllers
  late final TextEditingController edtControllerID;
  late final TextEditingController edtControllerLabel;
  late final TextEditingController edtControllerMinTemp;
  late final TextEditingController edtControllerMaxTemp;

  final _audioPlayer = AudioPlayer();

  void playError(bool play) async {
    await _audioPlayer.setAsset(AppUrls.bipAudio);

    for (int i = 0; i < 2; i++) {
      await _audioPlayer.play();
      if (i < 1) {
        await Future.delayed(const Duration(seconds: 1));
      }
    }

    _audioPlayer.pause();
  }

  bool isTempOut(ShowSensor data) {
    final temperature = data.currentTemperature?.temperature;

    final maxTemp = int.tryParse(data.max);
    final minTemp = int.tryParse(data.min);

    if (temperature != null && maxTemp != null && minTemp != null) {
      return temperature > maxTemp || temperature < minTemp;
    }

    return false;
  }

  Future<List<ShowSensor>> sensorListApi() async {
    try {
      final sensors = await _api.getSensorList();
      sensorList.assignAll(sensors);
      return sensors;
    } catch (e) {
      error.value = e.toString();
      rethrow;
    }
  }

  Future<void> createNewSensor(CreateSensor sensor) async {
    try {
      await _api.createSensor(sensor);
      await Future.delayed(const Duration(seconds: 2));
      refreshApi();
    } catch (e) {
      error.value = e.toString();
      rethrow;
    }
  }

  Future<void> refreshApi() => sensorListApi();

  @override
  void onInit() {
    super.onInit();
    refreshApi();
    edtControllerID = TextEditingController();
    edtControllerLabel = TextEditingController();
    edtControllerMinTemp = TextEditingController();
    edtControllerMaxTemp = TextEditingController();

    interval(
      sensorList,
      (_) => refreshApi(),
      time: const Duration(minutes: 15),
    );
  }

  @override
  void onReady() {
    refreshApi();
    super.onReady();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    edtControllerID.dispose();
    edtControllerLabel.dispose();
    edtControllerMinTemp.dispose();
    edtControllerMaxTemp.dispose();
    super.dispose();
  }
}
