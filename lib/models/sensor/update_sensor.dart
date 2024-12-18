class UpdateSensor {
  final String? label;
  final String? min;
  final String? max;

  UpdateSensor({
    this.label,
    this.min,
    this.max,
  });

  factory UpdateSensor.fromJson(Map<String, dynamic>? json) => UpdateSensor(
        label: json?["label"] ?? "--",
        min: json?["min"] ?? "-0-",
        max: json?["max"] ?? "-0-",
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "min": min,
        "max": max,
      };
}
