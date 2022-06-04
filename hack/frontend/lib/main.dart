import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/back_logic.dart/back.dart';
import 'package:frontend/back_logic.dart/model_rate_def.dart';
import 'package:frontend/defor_rate.dart';
import 'package:frontend/img_ana.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _buildTheme(brightness) {
      var baseTheme = ThemeData(
          canvasColor: CupertinoColors.darkBackgroundGray,
          appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(255, 25, 25, 25)),
          scaffoldBackgroundColor: CupertinoColors.darkBackgroundGray,
          brightness: brightness);

      return baseTheme.copyWith(
        textTheme: GoogleFonts.sourceSansProTextTheme(baseTheme.textTheme),
      );
    }

    return ChangeNotifierProvider<BackLogic>(
      create: (ctx) => BackLogic(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _buildTheme(Brightness.dark),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shadowColor: null,
        centerTitle: true,
        title: Text(
          "Amazon Deforestation",
          style: Theme.of(context).textTheme.headline5,
        ),
        actions: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Text("Deforestation Rate",
                style: Theme.of(context).textTheme.button),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => const DefroRate(),
              ),
            ),
          ),
          const SizedBox(width: 10),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Text("Satellite Images",
                style: Theme.of(context).textTheme.button),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => const ImageAnaly(),
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      drawer: Drawer(
          width: MediaQuery.of(context).size.width * 0.5,
          child: const Sliders()),
      body: Consumer<BackLogic>(builder: (context, data, _) {
        return Row(
          children: [
            data.map == null
                ? const SizedBox.shrink()
                : data.map!.continent!.isNotEmpty
                    ? Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width * 0.24,
                          decoration: BoxDecoration(
                              color: CupertinoColors.black.withOpacity(0.2)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                              children: [
                                Text("Prediction",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall),
                                const SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                          '${data.initalDay.round().toString()} / ${data.initalMonth.round().toString()} / ${data.initalYear.round().toString()}'),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                              data.map!.latitude!
                                                  .toStringAsFixed(2),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4),
                                          Text('Latitude',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                              data.map!.longitude!
                                                  .toStringAsFixed(2),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4),
                                          Text('Longitude',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: data
                                      .map!.localityInfo!.administrative!
                                      .map((e) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                            color: CupertinoColors
                                                .darkBackgroundGray),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(e.name!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1),
                                              Text(e.description!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: data.map!.localityInfo!.informative!
                                      .map((e) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                            color: CupertinoColors
                                                .darkBackgroundGray),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(e.name!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1),
                                              Text(e.description!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: SfMaps(
                    layers: [
                      MapShapeLayer(
                        zoomPanBehavior: data.zoomPanBehavior,
                        onWillPan: (MapPanDetails details) {
                          return true;
                        },
                        onWillZoom: (MapZoomDetails details) {
                          return true;
                        },
                        color: CupertinoColors.darkBackgroundGray,
                        controller: data.layerController,
                        markerTooltipBuilder:
                            (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: CupertinoColors.systemPurple.darkColor,
                            ),
                            width: MediaQuery.of(context).size.width * 0.15,
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: Column(
                              children: [
                                Text(data.map!.continent!,
                                    style:
                                        Theme.of(context).textTheme.headline6),
                                Text(data.map!.countryName!),
                                Text(data.map!.city!),
                              ],
                            ),
                          );
                        },
                        markerBuilder: (BuildContext context, int index) {
                          return MapMarker(
                            size: const Size(20, 20),
                            latitude: data.map!.latitude!,
                            longitude: data.map!.longitude!,
                          );
                        },
                        source: const MapShapeSource.asset(
                          'assets/brazil.json',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class Sliders extends StatelessWidget {
  const Sliders({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BackLogic>(builder: (context, data, _) {
      return ListView(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pop(context)),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Area in km^2",
                    style: Theme.of(context).textTheme.bodyText1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SliderTheme(
                        data: const SliderThemeData(
                            thumbColor: Colors.green,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 5)),
                        child: Slider(
                            activeColor: CupertinoColors.activeGreen,
                            divisions: 34,
                            min: 0.09,
                            max: 1.41,
                            value: data.initalArea,
                            onChanged: (s) => data.changeAreavalue(s)),
                      ),
                    ),
                    Text(
                      data.initalArea.toStringAsFixed(2).padLeft(6),
                      style: Theme.of(context).textTheme.headline4,
                    )
                  ],
                ),
                Text("Day", style: Theme.of(context).textTheme.bodyText1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SliderTheme(
                        data: const SliderThemeData(
                            thumbColor: Colors.green,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 5)),
                        child: Slider(
                            activeColor: CupertinoColors.activeGreen,
                            divisions: 30,
                            min: 1,
                            max: 30,
                            value: data.initalDay,
                            onChanged: (s) => data.changeDayvalue(s)),
                      ),
                    ),
                    Text(
                      data.initalDay.round().toString().padLeft(10),
                      style: Theme.of(context).textTheme.headline4,
                    )
                  ],
                ),
                Text("Month", style: Theme.of(context).textTheme.bodyText1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SliderTheme(
                        data: const SliderThemeData(
                            thumbColor: Colors.green,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 5)),
                        child: Slider(
                            activeColor: CupertinoColors.activeGreen,
                            divisions: 12,
                            min: 1,
                            max: 12,
                            value: data.initalMonth,
                            onChanged: (s) => data.changeMonthvalue(s)),
                      ),
                    ),
                    Text(
                      data.initalMonth.round().toString().padLeft(10),
                      style: Theme.of(context).textTheme.headline4,
                    )
                  ],
                ),
                Text("Year", style: Theme.of(context).textTheme.bodyText1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SliderTheme(
                        data: const SliderThemeData(
                            thumbColor: Colors.green,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 5)),
                        child: Slider(
                            activeColor: CupertinoColors.activeGreen,
                            divisions: 16,
                            min: 2008,
                            max: 2024,
                            value: data.initalYear,
                            onChanged: (s) => data.changeYearvalue(s)),
                      ),
                    ),
                    Text(
                      data.initalYear.round().toString(),
                      style: Theme.of(context).textTheme.headline4,
                    )
                  ],
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: CupertinoColors.darkBackgroundGray),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: data.placeSelectedValue,
                    items: data.placeName
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              style: Theme.of(context).textTheme.bodyText1,
                            )))
                        .toList(),
                    onChanged: (s) => data.changeDropDownPlace(s!),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}


//  <MapShapeLayer>[
            //   MapShapeLayer(
            //     source: data.mapSource,
            //     showDataLabels: true,
            //     legend: const MapLegend(MapElement.shape),
            //     tooltipSettings: MapTooltipSettings(
            //         color: Colors.teal[700],
            //         strokeColor: Colors.white,
            //         strokeWidth: 1),
            //     strokeColor: Colors.white,
            //     strokeWidth: 0.5,
            //     shapeTooltipBuilder: (BuildContext context, int index) {
            //       return Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Text(
            //           data.dataX[index].stateCode,
            //           style: const TextStyle(color: Colors.white),
            //         ),
            //       );
            //     },
            //     dataLabelSettings: MapDataLabelSettings(
            //         textStyle: TextStyle(
            //             color: Colors.black,
            //             fontWeight: FontWeight.bold,
            //             fontSize:
            //                 Theme.of(context).textTheme.caption!.fontSize)),
            //   ),
            // ],
            //Color.fromARGB(255, 0, 52, 107)),