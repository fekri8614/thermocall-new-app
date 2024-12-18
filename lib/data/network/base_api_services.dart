abstract class BaseApiServices {
  Future<dynamic> getApi({required String url, required String userId});

  Future<dynamic> postApi({
    required String url,
    Object? data,
    required String userId,
  });

  Future<dynamic> updateApi({
    required String url,
    required String sensorId,
    Object? data,
    required String userId,
  });

  Future<dynamic> deleteApi({
    required String url,
    required String sensorId,
    Object? data,
    required String userId,
  });
}
