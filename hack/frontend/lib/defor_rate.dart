import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:frontend/back_logic.dart/back.dart';
import 'package:frontend/back_logic.dart/model_rate_def.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DefroRate extends StatelessWidget {
  const DefroRate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Deforestation Rate',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: Consumer<BackLogic>(builder: (context, data, _) {
        return data.dataTX == null
            ? const CircularProgressIndicator()
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: SfCartesianChart(
                    legend: Legend(
                      isVisible: true,
                    ),
                    primaryXAxis: CategoryAxis(
                        isVisible: true, title: AxisTitle(text: "Years")),
                    primaryYAxis: CategoryAxis(
                        isVisible: true,
                        title: AxisTitle(text: "Rate (Km/sq)")),
                    series: <ChartSeries>[
                      LineSeries<Coordinate, String>(
                          legendItemText: data.placeName[0],
                          dataSource: data.dataTX!.para,
                          xValueMapper: (data, _) => data.year,
                          yValueMapper: (data, _) => data.rates),
                      LineSeries<Coordinate, String>(
                          legendItemText: data.placeName[1],
                          dataSource: data.dataTX!.matogrosso,
                          xValueMapper: (data, _) => data.year,
                          yValueMapper: (data, _) => data.rates),
                      LineSeries<Coordinate, String>(
                          legendItemText: data.placeName[2],
                          dataSource: data.dataTX!.rondonia,
                          xValueMapper: (data, _) => data.year,
                          yValueMapper: (data, _) => data.rates),
                      LineSeries<Coordinate, String>(
                          legendItemText: data.placeName[3],
                          dataSource: data.dataTX!.amazonas,
                          xValueMapper: (data, _) => data.year,
                          yValueMapper: (data, _) => data.rates),
                      LineSeries<Coordinate, String>(
                          legendItemText: data.placeName[4],
                          dataSource: data.dataTX!.maranhao,
                          xValueMapper: (data, _) => data.year,
                          yValueMapper: (data, _) => data.rates),
                      LineSeries<Coordinate, String>(
                          legendItemText: data.placeName[5],
                          dataSource: data.dataTX!.acre,
                          xValueMapper: (data, _) => data.year,
                          yValueMapper: (data, _) => data.rates),
                      LineSeries<Coordinate, String>(
                          legendItemText: data.placeName[6],
                          dataSource: data.dataTX!.roraima,
                          xValueMapper: (data, _) => data.year,
                          yValueMapper: (data, _) => data.rates),
                      LineSeries<Coordinate, String>(
                          legendItemText: data.placeName[7],
                          dataSource: data.dataTX!.amapa,
                          xValueMapper: (data, _) => data.year,
                          yValueMapper: (data, _) => data.rates),
                      LineSeries<Coordinate, String>(
                          legendItemText: data.placeName[8],
                          dataSource: data.dataTX!.tocantis,
                          xValueMapper: (data, _) => data.year,
                          yValueMapper: (data, _) => data.rates),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
