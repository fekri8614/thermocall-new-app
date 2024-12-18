class CreateSensor {
  final String sensorId;
  final String label;
  final String min;
  final String max;

  CreateSensor({
    required this.sensorId,
    required this.label,
    required this.min,
    required this.max,
  });

  factory CreateSensor.fromJson(Map<String, dynamic> json) => CreateSensor(
        sensorId: json["sensorId"],
        label: json["label"],
        min: json["min"],
        max: json["max"],
      );

  Map<String, dynamic> toJson() => {
        "sensorId": sensorId,
        "label": label,
        "min": min,
        "max": max,
      };
}
