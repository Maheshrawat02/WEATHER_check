import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:weather/modules/weather/controllers/weather_controller.dart';
import 'package:weather/modules/weather/views/forecast_view.dart';

class HomeView extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  final WeatherController controller = Get.put(WeatherController());

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF4F0FF),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 30),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff7C3AED),
                      Color(0xff4F46E5),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "WEATHER",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            onSubmitted: (value) async {
                              await controller.searchWeather(searchController.text);
                            },
                            decoration: InputDecoration(
                              hintText: "Search a city...",
                              prefixIcon: const Icon(
                                Icons.location_on,
                                color: Color(0xff6D28FF),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 18,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),

                        const Gap(10),

                        Container(
                          height: 58,
                          width: 58,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xff7C3AED),
                                Color(0xff4F46E5),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: IconButton(
                            onPressed: () async {
                              await controller.searchWeather(searchController.text);
                            },
                            icon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const Gap(25),

                    Obx(() {
                      if (controller.isLoading.value) {
                        return const LinearProgressIndicator();
                      }

                      if (controller.error.value.isNotEmpty) {
                        return Text(controller.error.value);
                      }

                      if (controller.weather.value == null) {
                        return const SizedBox();
                      }

                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Colors.white,
                              Color(0xffEEE7FF),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 18,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.cloud,
                              size: 90,
                              color: Color(0xff7C3AED),
                            ),

                            const Gap(15),

                            Text(
                              controller.weather.value!.cityName,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff1F2937),
                              ),
                            ),

                            const Gap(10),

                            Text(
                              "${controller.weather.value!.temperature}°C",
                              style: const TextStyle(
                                fontSize: 52,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff6D28FF),
                              ),
                            ),

                            const Gap(8),

                            Text(
                              controller.weather.value!.condition,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),

                    const Gap(30),

                    SizedBox(
                      width: 230,
                      height: 55,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xff6D28FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          Get.to(() => ForecastView());
                        },
                        icon: const Icon(Icons.calendar_month),
                        label: const Text(
                          "See Forecast",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}