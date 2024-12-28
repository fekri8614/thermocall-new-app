import 'package:logger/logger.dart';
import 'package:thermocall_new2/models/sensor/update_sensor.dart';

import '../../data/app_exceptions.dart';
import '../../data/network/network_api_services.dart';
import '../../models/sensor/single_sensor.dart';
import '../../res/app_urls/app_urls.dart';

class SetupRepository {
  final _apiService = NetworkApiServices();
  final Logger _logger = Logger();

  Future<SingleSensor> getSingleSensor(String sensorId) async {
    try {
      final response = await _apiService.getApi(
        url: "${AppUrls.sensorListApi}/$sensorId",
        userId: AppUrls.userId,
      );
      return SingleSensor.fromJson(response);
    } catch (e) {
      _logger.e("Failed to fetch single sensor: $e");
      throw FetchDataException('Failed to fetch single sensor');
    }
  }

  Future<void> updateSensorData(String sensorId, UpdateSensor sensor) async {
    try {
      await _apiService.updateApi(
        url: AppUrls.sensorListApi,
        sensorId: sensorId,
        data: sensor.toJson(),
        userId: AppUrls.userId,
      );
    } catch (e) {
      _logger.e("Failed to update sensor data: $e");
      throw FetchDataException('Failed to update sensor data');
    }
  }

  Future<void> deleteSensor(String sensorId) async {
    try {
      await _apiService.deleteApi(
        url: AppUrls.sensorListApi,
        sensorId: sensorId,
        userId: AppUrls.userId,
      );
    } catch (e) {
      _logger.e("Failed to delete sensor: $e");
      throw FetchDataException('Failed to delete sensor');
    }
  }
}
