import 'current_temperature.dart';

class SingleSensor {
  final String sensorId;
  String label;
  final String min;
  final String max;
  final CurrentTemperature? currentTemperature;

  SingleSensor({
    required this.sensorId,
    required this.label,
    required this.min,
    required this.max,
    this.currentTemperature,
  });

  factory SingleSensor.fromJson(Map<String, dynamic>? json) => SingleSensor(
        sensorId: json?["sensorId"] ?? "--",
        label: json?["label"] ?? "--",
        min: (json?["min"]?.toString()) ?? "-0-",
        max: (json?["max"]?.toString()) ?? "-0-",
        currentTemperature: CurrentTemperature.fromJson(
          json?["currentTemperature"] ??
              CurrentTemperature(temperature: null, timestamp: DateTime.now())
                  .toJson(),
        ),
      );

  Map<String, dynamic> toJson() => {
        "sensorId": sensorId,
        "label": label,
        "min": min,
        "max": max,
        "currentTemperature": currentTemperature?.toJson(),
      };
}
