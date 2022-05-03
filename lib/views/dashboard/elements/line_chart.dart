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
    if (sensorDataState is SensorDataErrorState) {
      return const Center(child: Text('Error loading data'));
    } else if (sensorDataState is SensorDataLoadedState) {
      final List<String> timestamps = sensorDataState.sensorData.history
          .map<String>((SensorDataEntry e) => e.dateTimeString)
          .toList();
      return _LineChart(
        chartData: _makeChartDataMap(sensorDataState.sensorData.history),
        xLabels: timestamps,
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  /// Return a map with the keys as the type of values to show in Line chart
  /// and values as the [List] of [FlSpot]s that the chart needs to show.
  Map<String, List<FlSpot>> _makeChartDataMap(List<SensorDataEntry> history) {
    // Prepare Data for chart
    final Map<String, List<FlSpot>> data = <String, List<FlSpot>>{
      'current': <FlSpot>[],
      'power': <FlSpot>[],
      'voltage': <FlSpot>[],
    };

    double x = 0;
    for (final SensorDataEntry dataEntry in history) {
      data['current']!.add(FlSpot(x, dataEntry.current));
      data['power']!.add(FlSpot(x, dataEntry.power));
      data['voltage']!.add(FlSpot(x, dataEntry.voltage));
      x += 1;
    }
    return data;
  }
}

class _LineChart extends StatefulWidget {
  const _LineChart({
    required Map<String, List<FlSpot>> chartData,
    List<dynamic>? xLabels,
    this.minX = 0,
    this.maxX,
    this.minY = 0,
    this.maxY,
    Key? key,
  })  : _chartData = chartData,
        _xLabels = xLabels,
        super(key: key);

  /// The data to be displayed in the chart.
  ///
  /// The keys of the map are the names of the series.
  /// The values are the data points of the series as a [List] of [FlSpot].
  final Map<String, List<FlSpot>> _chartData;

  /// The labels to be shown in the bottom accross the X-axis as Strings.
  ///
  /// If Null, the direct X-axis values are used.
  final List<dynamic>? _xLabels;

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

    final ThemeData theme = Theme.of(context);
    final List<Color> _gradientColors = <Color>[
      theme.colorScheme.primary,
      theme.colorScheme.secondary,
    ];
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (double value) => FlLine(
                    color: const Color(0xff37434d),
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: SideTitles(showTitles: false),
                  topTitles: SideTitles(showTitles: false),
                  bottomTitles: SideTitles(
                    getTextStyles: (BuildContext context, double value) =>
                        TextStyle(
                      color: theme.colorScheme.outline,
                      fontWeight: FontWeight.bold,
                      fontSize: 8,
                    ),
                    getTitles: (double x) => x >= (widget._xLabels?.length ?? 0)
                        ? x.floor().toString()
                        : widget._xLabels![x.floor()].toString(),
                    margin: 12,
                    rotateAngle: 90,
                    reservedSize: 22,
                    showTitles: true,
                  ),
                  leftTitles: SideTitles(
                    getTextStyles: (BuildContext context, double value) =>
                        TextStyle(
                      color: theme.colorScheme.outline,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                    getTitles: (double y) {
                      if (y.floor() == y) {
                        return y.toStringAsFixed(0);
                      } else if (y > 0.0009) {
                        return y.toStringAsFixed(3);
                      } else {
                        return y.toStringAsExponential(3);
                      }
                    },
                    reservedSize: 45,
                    showTitles: true,
                    margin: 6,
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    color: theme.colorScheme.background,
                    width: 1,
                  ),
                ),
                minX: minX,
                maxX: maxX,
                minY: minY - minY / 2,
                maxY: maxY + maxY / 2,
                lineBarsData: <LineChartBarData>[
                  LineChartBarData(
                    spots: chartSpots,
                    isCurved: false,
                    colors: _gradientColors,
                    barWidth: 3,
                    isStrokeCapRound: false,
                    dotData: FlDotData(
                      show: false,
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      colors: _gradientColors
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
          height: 30,
          child: TextButton(
            onPressed: () => setState(
              () => _showingDataIndex = (_showingDataIndex + 1) %
                  widget._supportedChartDataTypeNames.length,
            ),
            child: Text(
              _showingData,
              style: TextStyle(
                color: theme.colorScheme.secondary,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
