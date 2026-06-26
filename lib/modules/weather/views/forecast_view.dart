import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/modules/weather/controllers/weather_controller.dart';

class ForecastView extends StatelessWidget {
  final WeatherController controller = Get.find<WeatherController>();

  ForecastView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F0FF),

      appBar: AppBar(
        title: const Text(
          "FORECAST",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xff6D28FF),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),

      body: Obx(() {
        if (controller.isLoading.value == true) {
          return const LinearProgressIndicator();
        }

        if (controller.error.value.isNotEmpty) {
          return Center(
            child: Text(
              controller.error.value,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
          );
        }

        if (controller.weather.value == null) {
          return const Center(
            child: Text(
              "Data Not Available",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: controller.forecasts.length,
          itemBuilder: (context, index) {
            final forecast = controller.forecasts[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      color: const Color(0xffEEE7FF),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.cloud,
                      color: Color(0xff6D28FF),
                      size: 30,
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          forecast.date.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          forecast.condition,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff1F2937),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Text(
                    "${forecast.temperature}°C",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff6D28FF),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}