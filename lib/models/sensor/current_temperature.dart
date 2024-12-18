class CurrentTemperature {
  double? temperature;
  DateTime timestamp;

  CurrentTemperature({
    required this.temperature,
    required this.timestamp,
  });

  factory CurrentTemperature.fromJson(Map<String, dynamic>? json) =>
      CurrentTemperature(
        temperature: (json?["temperature"] as num?)?.toDouble(),
        timestamp: DateTime.parse(json?["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "temperature": temperature,
        "timestamp": timestamp.toIso8601String(),
      };
}
