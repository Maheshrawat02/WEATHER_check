import 'package:dio/dio.dart';
import 'package:weather/modules/weather/models/forecast_model.dart';
import 'package:weather/modules/weather/models/weather_model.dart';

class WeatherService {
  final Dio dio = Dio();

  // weather
  Future<WeatherModel> getWeather(String cityName) async{
    Response response = await dio.get("https://api.openweathermap.org/data/2.5/weather",
    queryParameters: {
      "q": cityName,
      "appid": "ef3299a46301ca01cad1f7bae5579af9",
      "units": "metric"
    }
    );

    var json = response.data;

    return WeatherModel.fromJson(json);
  }

  // Forecast
  Future<List<ForecastModel>> getForecast(String cityName) async{
    Response response = await dio.get("https://api.openweathermap.org/data/2.5/forecast",
    queryParameters: {
      "q": cityName,
      "appid": "ef3299a46301ca01cad1f7bae5579af9",
      "units": "metric"
    }
    );

    var forecastList = response.data["list"];

    return forecastList.map<ForecastModel>((json) => ForecastModel.fromJson(json)).toList();
  }

}

