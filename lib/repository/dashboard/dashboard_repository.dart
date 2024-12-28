import 'package:logger/logger.dart';
import 'package:thermocall_new2/data/network/network_api_services.dart';
import 'package:thermocall_new2/models/sensor/create_sensor.dart';
import 'package:thermocall_new2/models/sensor/show_sensor.dart';
import 'package:thermocall_new2/res/app_urls/app_urls.dart';

import '../../data/app_exceptions.dart';

class DashboardRepository {
  final _apiService = NetworkApiServices();
  final Logger _logger = Logger();

  Future<List<ShowSensor>> getSensorList() async {
    try {
      final response = await _apiService.getApi(
        url: AppUrls.sensorListApi,
        userId: AppUrls.userId,
      );

      // Assuming the response is a list of sensors
      return (response as List)
          .map((sensor) => ShowSensor.fromJson(sensor))
          .toList();
    } catch (e) {
      _logger.e("Failed to fetch sensor list: $e");
      throw FetchDataException('Failed to fetch sensor list');
    }
  }

  Future<void> createSensor(CreateSensor data) async {
    try {
      await _apiService.postApi(
        url: AppUrls.sensorListApi,
        userId: AppUrls.userId,
        data: data.toJson(),
      );
    } catch (e) {
      _logger.e("Failed to create sensor: $e");
      throw FetchDataException('Failed to create sensor');
    }
  }
}
