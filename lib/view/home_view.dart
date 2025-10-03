import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import '../components/build_body.dart';
import '../components/build_header.dart';
import '../components/build_loading_ui.dart';
import '../data/response/status.dart';
import '../model/WeatherModel.dart';
import '../view_model/home_view_model.dart';
import '../view_model/scroll_effect_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().FetchWeatherData();
    });

    _scrollController.addListener(() {
      // small debounce to prevent rebuild spam
      final offset = _scrollController.offset;
      Future.microtask(() {
        if (mounted) {
          context.read<ScrollEffectViewModel>().updateOffset(offset);
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, _) {
        final status = viewModel.weatherData.status;
        if (status == Status.ERROR) {
          return Scaffold(
            appBar: AppBar(title: const Text('Weather Forecast')),
            body: Center(
              child: Text(
                'Error: ${viewModel.weatherData.message}',
                style: TextStyle(color: Colors.red, fontSize: 16.sp),
              ),
            ),
          );
        }
        if (status == Status.LOADING && viewModel.weatherData.data == null) {
          return buildLoadingUI();
        }
        if (status == Status.COMPLETED || viewModel.weatherData.data != null) {
          final WeatherModel weather = viewModel.weatherData.data!;
          final remainingTodayIndices = viewModel.getRemainingTodayIndices();
          double currentPrecip = 0;
          if (remainingTodayIndices.isNotEmpty) {
            final nextHourIndex = remainingTodayIndices.first;
            currentPrecip = weather.hourly.precipitation[nextHourIndex];
          }
          final bool isDay = weather.current.isDay == 1;
          final Color topTextColor = isDay ? Colors.black : Colors.white;
          final Color subTextColor = isDay ? Colors.black54 : Colors.white70;
          final Color fadedTextColor = isDay ? Colors.black45 : Colors.white54;

          return Scaffold(
            body: Stack(
              children: [
                // Background image
                Positioned.fill(
                  child: Image.asset(
                    isDay ? "images/sunny_bg.jpg" : "images/night_bg.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                // Blur + overlay controlled by ScrollEffectViewModel
                Positioned.fill(
                  child: Consumer<ScrollEffectViewModel>(
                    builder: (context, scrollEffect, _) {
                      return ClipRect(
                        child: BackdropFilter(
                          filter: ui.ImageFilter.blur(
                            sigmaX: scrollEffect.blurAmount,
                            sigmaY: scrollEffect.blurAmount,
                          ),
                          child: Container(
                            color: Colors.white.withOpacity(scrollEffect.overlayOpacity),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Rest of the Scrollable Home View
                NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        expandedHeight: 0.65.sh,
                        floating: false,
                        pinned: false,
                        backgroundColor: Colors.transparent,
                        flexibleSpace: FlexibleSpaceBar(
                          background: buildHeader(
                            weather,
                            viewModel,
                            topTextColor,
                            subTextColor,
                            fadedTextColor,
                          ),
                        ),
                      ),
                    ];
                  },
                  body: buildBody(weather, remainingTodayIndices, currentPrecip),
                ),
              ],
            ),
          );
        }

        return buildLoadingUI();
      },
    );
  }
}
