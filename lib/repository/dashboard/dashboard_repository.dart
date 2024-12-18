import 'package:thermocall_new2/data/network/network_api_services.dart';
import 'package:thermocall_new2/models/sensor/create_sensor.dart';
import 'package:thermocall_new2/models/sensor/show_sensor.dart';
import 'package:thermocall_new2/res/app_urls/app_urls.dart';

class DashboardRepository {
  final _apiService = NetworkApiServices();

  Future<List<ShowSensor>> getSensorList() async {
    final response = await _apiService.getApi(
      url: AppUrls.sensorListApi,
      userId: AppUrls.userId,
    );

    // Assuming the response is a list of sensors
    return (response as List)
        .map((sensor) => ShowSensor.fromJson(sensor))
        .toList();
  }

  Future<void> createSensor(CreateSensor data) async =>
      await _apiService.postApi(
        url: AppUrls.sensorListApi,
        userId: AppUrls.userId,
        data: data.toJson(),
      );
}
