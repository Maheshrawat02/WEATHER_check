import 'package:get/get.dart';
import 'package:weather/modules/weather/models/forecast_model.dart';
import 'package:weather/modules/weather/models/weather_model.dart';
import 'package:weather/modules/weather/services/weather_service.dart';

class WeatherController extends GetxController{
 WeatherService service = WeatherService();

 final weather = Rxn<WeatherModel>();
 final forecasts = <ForecastModel>[].obs;

 var isLoading = false.obs;
 var error ="".obs;

 Future searchWeather(String cityName) async{

  try{
    isLoading(true);
    error("");

    weather.value = await service.getWeather(cityName);
    forecasts.value = await service.getForecast(cityName);
  
  }catch(e){

    error(e.toString());
    print(error);
  
  }finally{
    isLoading(false);
  }
 }

}