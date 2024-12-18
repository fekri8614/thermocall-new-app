import 'package:thermocall_new2/models/sensor/update_sensor.dart';

import '../../data/network/network_api_services.dart';
import '../../models/sensor/single_sensor.dart';
import '../../res/app_urls/app_urls.dart';

class SetupRepository {
  final _apiService = NetworkApiServices();

  Future<SingleSensor> getSingleSensor(String sensorId) async {
    final response = await _apiService.getApi(
      url: "${AppUrls.sensorListApi}/$sensorId",
      userId: AppUrls.userId,
    );

    return SingleSensor.fromJson(response);
  }

  Future<void> updateSensorData(String sensorId, UpdateSensor sensor) async {
    await _apiService.updateApi(
      url: AppUrls.sensorListApi,
      sensorId: sensorId,
      data: sensor.toJson(),
      userId: AppUrls.userId,
    );
  }

  Future<void> deleteSensor(String sensorId) async {
    await _apiService.deleteApi(
      url: AppUrls.sensorListApi,
      sensorId: sensorId,
      userId: AppUrls.userId,
    );
  }
}
