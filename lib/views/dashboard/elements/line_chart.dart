import 'dart:math' show min, max;

import 'package:electrometer/bloc/sensor_data/sensor_data_bloc.dart';
import 'package:electrometer/models/sensor_data_models/sensor_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// Shows a chart for the real time power usage readings as a line chart.
class DashboardPowerChart extends StatelessWidget {
  /// Creates a new instance of the [DashboardPowerChart] class.
  const DashboardPowerChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SensorDataState sensorDataState =
        context.watch<SensorDataBloc>().state;
    // Build the chart if the data is available.
    if (sensorDataState is SensorDataLoadedState) {
      final Map<String, SensorDataEntry> history =
          sensorDataState.sensorData.history;
      // Prepare Data for chart
      final Map<String, List<FlSpot>> data = <String, List<FlSpot>>{
        'current': <FlSpot>[],
        'power': <FlSpot>[],
        'voltage': <FlSpot>[],
      };
      double x = 0;
      history.forEach(
        (String timestamp, SensorDataEntry dataEntry) {
          final double time = (DateTime.tryParse(timestamp) ?? DateTime.now())
              .millisecondsSinceEpoch
              .toDouble();
          data['current']!.add(FlSpot(x, dataEntry.current));
          data['power']!.add(FlSpot(x, dataEntry.power));
          data['voltage']!.add(FlSpot(x, dataEntry.voltage));
          x += 1;
        },
      );
      return _LineChart(chartData: data);
    } else if (sensorDataState is SensorDataErrorState) {
      return const Center(child: Text('Error loading data'));
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}

class _LineChart extends StatefulWidget {
  const _LineChart({
    required Map<String, List<FlSpot>> chartData,
    this.minX = 0,
    this.maxX,
    this.minY = 0,
    this.maxY,
    Key? key,
  })  : _chartData = chartData,
        super(key: key);

  /// The data to be displayed in the chart.
  ///
  /// The keys of the map are the names of the series.
  /// The values are the data points of the series as a [List] of [FlSpot].
  final Map<String, List<FlSpot>> _chartData;

  /// The names of the data types that are supported and shown by this chart.
  ///
  /// These must be the keys of the [_chartData] map.
  List<String> get _supportedChartDataTypeNames => _chartData.keys.toList();

  /// The [double] minimum value of the x axis.
  final double? minX;

  /// The [double] maximum value of the x axis.
  final double? maxX;

  /// The [double] minimum value of the y axis.
  final double? minY;

  /// The [double] maximum value of the y axis.
  final double? maxY;

  @override
  _LineChartState createState() => _LineChartState();
}

class _LineChartState extends State<_LineChart> {
  List<Color> gradientColors = <Color>[
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  late int _showingDataIndex;

  String get _showingData =>
      widget._supportedChartDataTypeNames[_showingDataIndex];

  @override
  void initState() {
    super.initState();
    // Ensure supported data types are available.
    if (widget._supportedChartDataTypeNames.isEmpty) {
      throw ArgumentError(
        'No supported chart data types set.',
        'widget._supportedChartDataTypes',
      );
    }
    _showingDataIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> chartSpots = widget._chartData[_showingData]!;

    // Get bounds
    bool areBoundsNull = widget.minX == null ||
        widget.maxX == null ||
        widget.minY == null ||
        widget.maxY == null;
    double minX = widget.minX ?? chartSpots.first.x;
    double maxX = widget.maxX ?? chartSpots.last.x;
    double minY = widget.minY ?? chartSpots.first.y;
    double maxY = widget.maxY ?? chartSpots.last.y;
    if (areBoundsNull) {
      for (final FlSpot spot in chartSpots) {
        minX = min(minX, spot.x);
        maxX = max(maxX, spot.x);
        minY = min(minY, spot.y);
        maxY = max(maxY, spot.y);
      }
    }

    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 18, top: 24),
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  getDrawingHorizontalLine: (double value) {
                    return FlLine(
                      color: const Color(0xff37434d),
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (double value) {
                    return FlLine(
                      color: const Color(0xff37434d),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: SideTitles(showTitles: false),
                  topTitles: SideTitles(showTitles: false),
                  bottomTitles: SideTitles(
                    getTextStyles: (BuildContext context, double value) =>
                        const TextStyle(
                      color: Color(0xff68737d),
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                    getTitles: (double x) => x.floor().toString(),
                    interval: 1,
                    reservedSize: 22,
                    showTitles: true,
                    margin: 8,
                  ),
                  leftTitles: SideTitles(
                    getTextStyles: (BuildContext context, double value) =>
                        const TextStyle(
                      color: Color(0xff67727d),
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                    getTitles: (double y) => y.toStringAsFixed(4),
                    reservedSize: 45,
                    showTitles: true,
                    margin: 6,
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: const Color(0xff37434d), width: 1),
                ),
                minX: minX,
                maxX: maxX,
                minY: minY - minY / 2,
                maxY: maxY + maxY / 2,
                lineBarsData: <LineChartBarData>[
                  LineChartBarData(
                    spots: chartSpots,
                    isCurved: true,
                    colors: gradientColors,
                    barWidth: 5,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: false,
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      colors: gradientColors
                          .map((Color color) => color.withOpacity(0.3))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 60,
          height: 34,
          child: TextButton(
            onPressed: () => setState(
              () => _showingDataIndex = (_showingDataIndex + 1) %
                  widget._supportedChartDataTypeNames.length,
            ),
            child: Text(
              _showingData,
              style: const TextStyle(fontSize: 10, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
