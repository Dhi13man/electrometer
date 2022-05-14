import 'dart:math' show min, max;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartImplementation extends StatefulWidget {
  const LineChartImplementation({
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
  _LineChartImplementationState createState() =>
      _LineChartImplementationState();
}

class _LineChartImplementationState extends State<LineChartImplementation> {
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
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 25),
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: AspectRatio(
            aspectRatio: 1.25,
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
                    getTitles: (double x) {
                      final int xLabelLength = widget._xLabels?.length ?? 0;
                      final int index = x.floor();
                      return (index >= xLabelLength)
                          ? index.toString()
                          : widget._xLabels![index].toString();
                    },
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
        ElevatedButton(
          onPressed: () => setState(
            () => _showingDataIndex = (_showingDataIndex + 1) %
                widget._supportedChartDataTypeNames.length,
          ),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(theme.colorScheme.primaryContainer),
          ),
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Text(
              _showingData.toUpperCase(),
              style: TextStyle(
                color: theme.colorScheme.secondary,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
