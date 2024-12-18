import 'current_temperature.dart';

class ShowSensor {
  final String id;
  final String sensorId;
  final String label;
  final String min;
  final String max;
  final CurrentTemperature? currentTemperature;

  ShowSensor({
    required this.id,
    required this.sensorId,
    required this.label,
    required this.min,
    required this.max,
    this.currentTemperature,
  });

  factory ShowSensor.fromJson(Map<String, dynamic>? json) => ShowSensor(
        id: json?["id"]?.toString() ?? "--",
        sensorId: json?["sensorId"]?.toString() ?? "--",
        label: json?["label"]?.toString() ?? "--",
        min: json?["min"]?.toString() ?? "-0-",
        max: json?["max"]?.toString() ?? "-0-",
        currentTemperature: CurrentTemperature.fromJson(
          json?["currentTemperature"] ??
              CurrentTemperature(temperature: null, timestamp: DateTime.now())
                  .toJson(),
        ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sensorId": sensorId,
        "label": label,
        "min": min,
        "max": max,
        "currentTemperature": currentTemperature?.toJson(),
      };
}
