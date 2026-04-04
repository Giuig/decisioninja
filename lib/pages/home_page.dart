// ignore_for_file: prefer_const, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:decisioninja/l10n/app_localizations.dart';
import 'package:ninja_material/utils/svg_util.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:provider/provider.dart'; // Import Provider

import '../utils/chart_data.dart';
import 'package:decisioninja/config/config.dart'; // Import config to access appStatsNotifier

class HomePageConfig {
  final Widget homeWidget;

  const HomePageConfig({required this.homeWidget});
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget _buildWelcomeText() {
    // Watch the AppStatsNotifier for changes
    final appStats = context.watch<AppStatsNotifier>();

    // Use the values from the AppStatsNotifier instance
    final leftRightCount = appStats.globalLeftRightCount;
    final diceCount = appStats.globalDiceCount;
    final pointerCount = appStats.globalPointerCount;
    final ninjaCount = appStats.globalNinjaCount;

    if (leftRightCount < 1 ||
        diceCount < 1 ||
        pointerCount < 1 ||
        ninjaCount < 1) {
      return Column(
        children: [
          Text(
            AppLocalizations.of(context)!.welcomeToDecisioninja,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "\"Make decisions like a ninja!\"",
            style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            AppLocalizations.of(context)!.statsDisplayedHere,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      );
    } else {
      final List<ChartData> chartData = [
        ChartData(
            AppLocalizations.of(context)!.leftRight,
            leftRightCount.toDouble(), // Use value from notifier
            Theme.of(context).colorScheme.primary),
        ChartData(
            AppLocalizations.of(context)!.dice,
            diceCount.toDouble(), // Use value from notifier
            Theme.of(context).colorScheme.primaryContainer),
        ChartData(
            AppLocalizations.of(context)!.pointer,
            pointerCount.toDouble(), // Use value from notifier
            Theme.of(context).colorScheme.tertiary),
        ChartData(
            AppLocalizations.of(context)!.ninja,
            ninjaCount.toDouble(), // Use value from notifier
            Theme.of(context).colorScheme.tertiaryContainer),
      ];

      Widget chartWidget = SfCartesianChart(
        title: ChartTitle(
          text: AppLocalizations.of(context)!.decisionsMadeSoFar,
          textStyle: TextStyle(fontSize: 18),
        ),
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(
          interval: 10,
        ),
        legend: Legend(
          isVisible: false,
        ),
        series: <CartesianSeries>[
          ColumnSeries<ChartData, String>(
            dataSource: chartData,
            pointColorMapper: (ChartData data, _) => data.color,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y.toInt(),
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
            ),
          ),
        ],
      );

      return chartWidget;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildWelcomeText(),
            Padding(
              padding: const EdgeInsets.only(
                top: 50,
                bottom: 15,
              ),
              child: SvgPicture.string(
                SvgUtil.decisioninjaSvgString,
                width: 100,
                height: 100,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.primaryContainer,
                  BlendMode.modulate,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
