class ForecastModel {
  final DateTime date;
  final double temperature;
  final String condition;

  ForecastModel({
    required this.date,
    required this.temperature,
    required this.condition,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json){
    return ForecastModel(
      date: DateTime.parse(json["dt_txt"]), 
      temperature: (json["main"]["temp"] as num).toDouble(), 
      condition: json["weather"][0]["main"]
    );
  }
}
