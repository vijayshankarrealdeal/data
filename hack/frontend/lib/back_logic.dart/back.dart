import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/back_logic.dart/model.dart';
import 'package:frontend/back_logic.dart/model_image.dart';
import 'package:frontend/back_logic.dart/model_rate_def.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:http/http.dart' as http;

class Model {
  Model(this.state, this.color, this.stateCode);

  String state;
  Color color;
  String stateCode;
}

class BackLogic extends ChangeNotifier {
  BackLogic() {
    getDeforattionData();
    getImageA();
  }
  late MapShapeSource mapSource;
  double initalArea = 0.09;
  double initalDay = 1;
  double initalMonth = 1;
  double initalYear = 2008;
  String placeSelectedValue = "Para";
  List get dataX => placeName.map((e) => Model(e, Colors.red, e)).toList();
  DataMap? map;
  MapShapeLayerController layerController = MapShapeLayerController();
  MapZoomPanBehavior zoomPanBehavior = MapZoomPanBehavior();
  DeforCall? dataTX;
  List<ImageAnalysic> dataAnl = [];
  void changeAreavalue(double s) {
    initalArea = s;
    notifyListeners();
  }

  Map<String, String> ss = {
    'haze':
        'Clouds are a major challenge for passive satellite imaging, and daily cloud cover and rain showers in the Amazon basin can significantly complicate monitoring in the area. For this reason we have chosen to include a cloud cover label for each chip. These labels closely mirror what one would see in a local weather forecast: clear, partly cloudy, cloudy, and haze. For our purposes haze is defined as any chip where atmospheric clouds are visible but they are not so opaque as to obscure the ground. Clear scenes show no evidence of clouds, and partly cloudy scenes can show opaque cloud cover over any portion of the image. Cloudy images have 90% of the chip obscured by opaque cloud cover.',
    'bare_ground':
        "Bare ground is a catch-all term used for naturally occuring tree free areas that aren't the result of human activity. Some of these areas occur naturally in the Amazon, while others may be the result from the source scenes containing small regions of biome much similar to the pantanal or cerrado.",
    'blow_down':
        'Blow down, also called windthrow, is a naturally occurring phenomenon in the Amazon. Briefly, blow down events occur during microbursts where cold dry air from the Andes settles on top of warm moist air in the rainforest. The colder air punches a hole in the moist warm layer, and sinks down with incredible force and high speed (in excess of 100MPH). These high winds topple the larger rainforest trees, and the resulting open areas are visible from space. The open areas do not stay visible for along as plants in the understory rush in to take advantage of the sunlight.',
    'artisinal_mine':
        'Artisinal mining is a catch-all term for small scale mining operations. Throughout the Amazon, especially at the foothills of the Andes, gold deposits lace the deep, clay soils. Artisanal miners, sometimes working illegally in land designated for conservation, slash through the forest and excavate deep pits near rivers. They pump a mud-water slurry into the river banks, blasting them away so that they can be processed further with mercury - which is used to separate out the gold. The denuded moonscape left behind takes centuries to recover.',
    'cloudy':
        'Clouds are a major challenge for passive satellite imaging, and daily cloud cover and rain showers in the Amazon basin can significantly complicate monitoring in the area. For this reason we have chosen to include a cloud cover label for each chip. These labels closely mirror what one would see in a local weather forecast: clear, partly cloudy, cloudy, and haze. For our purposes haze is defined as any chip where atmospheric clouds are visible but they are not so opaque as to obscure the ground. Clear scenes show no evidence of clouds, and partly cloudy scenes can show opaque cloud cover over any portion of the image. Cloudy images have 90% of the chip obscured by opaque cloud cover.',
    'water':
        'Rivers, reservoirs, and oxbow lakes are important features of the Amazon basin, and we used the water tag as a catch-all term for these features. Rivers in the Amazon basin often change course and serve as highways deep into the forest. The changing course of these rivers creates new habitat but can also strand endangered Amazon River Dolphins.',
    'blooming':
        'Blooming is a natural phenomenon found in the Amazon where particular species of flowering trees bloom, fruit, and flower at the same time to maximize the chances of cross pollination. These trees are quite large and these events can be seen from space. Planet recently captured a similar event in Panama.',
    'habitation':
        'The habitation class label was used for chips that appeared to contain human homes or buildings. This includes anything from dense urban centers to rural villages along the banks of rivers. Small, single-dwelling habitations are often difficult to spot but usually appear as clumps of a few pixels that are bright white.',
    'slash_burn':
        'Slash-and-burn agriculture can be considered to be a subset of the shifting cultivation label and is used for areas that demonstrate recent burn events. This is to say that the shifting cultivation patches appear to have dark brown or black areas consistent with recent burning.This NASA Earth Observatory article gives a good primer on the practice as does this wikipedia article. Above: ground view of slash and burn agriculture. By Alzenir Ferreira de Souza',
    'selective_logging':
        'The selective logging label is used to cover the practice of selectively removing high value tree species from the rainforest (such as teak and mahogany). From space this appears as winding dirt roads adjacent to bare brown patches in otherwise primary rain forest. This Mongabay Article covers the details of this process. Global Forest Watch is another great resource for learning about deforestation and logging.',
    'conventional_mine':
        'There are a number of large conventional mines in the Amazon basin and the number is steadily growning. This label is used to classify large-scale legal mining operations.',
    'agriculture':
        'Commercial agriculture, while an important industry, is also a major driver of deforestation in the Amazon. For the purposes of this dataset, agriculture is considered to be any land cleared of trees that is being used for agriculture or range land.',
    'road':
        'Roads are important for transportation in the Amazon but they also serve as drivers of deforestation. In particular, "fishbone" deforestation often follows new road construction, while smaller logging roads drive selective logging operations. For our data, all types of roads are labeled with a single "road" label. Some rivers look very similar to smaller logging roads, and consequently there may be some noise in this label. Analysis of the image using the near infrared band may prove useful in disambiguating the two classes.',
    'partly_cloudy':
        'Clouds are a major challenge for passive satellite imaging, and daily cloud cover and rain showers in the Amazon basin can significantly complicate monitoring in the area. For this reason we have chosen to include a cloud cover label for each chip. These labels closely mirror what one would see in a local weather forecast: clear, partly cloudy, cloudy, and haze. For our purposes haze is defined as any chip where atmospheric clouds are visible but they are not so opaque as to obscure the ground. Clear scenes show no evidence of clouds, and partly cloudy scenes can show opaque cloud cover over any portion of the image. Cloudy images have 90% of the chip obscured by opaque cloud cover.',
    'clear':
        'Clouds are a major challenge for passive satellite imaging, and daily cloud cover and rain showers in the Amazon basin can significantly complicate monitoring in the area. For this reason we have chosen to include a cloud cover label for each chip. These labels closely mirror what one would see in a local weather forecast: clear, partly cloudy, cloudy, and haze. For our purposes haze is defined as any chip where atmospheric clouds are visible but they are not so opaque as to obscure the ground. Clear scenes show no evidence of clouds, and partly cloudy scenes can show opaque cloud cover over any portion of the image. Cloudy images have 90% of the chip obscured by opaque cloud cover.',
    'primary':
        'The overwhelming majority of the data set is labeled as "primary", which is shorthand for primary rainforest, or what is known colloquially as virgin forest. Generally speaking, the "primary" label was used for any area that exhibited dense tree cover.This Mongobay article gives a concise description of the difference between primary and secondary rainforest, but distinguishing between the two is difficult solely using satellite imagery. ',
    'cultivation':
        'Shifting cultivation is a subset of agriculture that is very easy to see from space, and occurs in rural areas where individuals and families maintain farm plots for subsistence. This article by MongaBay by MongaBay gives a detailed overview of the practice. This type of agriculture is often found near smaller villages along major rivers, and at the outskirts of agricultural areas. It typically relies on non-mechanized labor, and covers relatively small areas.'
  };

  void predict() async {
    var uri = Uri.parse(
        'http://127.0.0.1:8000/?area=${double.parse(initalArea.toStringAsFixed(2))}&day=${initalDay.round()}&month=${initalMonth.round()}&year=${initalYear.round()}&state=$placeSelectedValue');
    final res = await http.get(uri, headers: {'accept': 'application/json'});
    map = DataMap.fromJson(json.decode(res.body));
    if (layerController.markersCount > 0) {
      layerController.clearMarkers();
    }
    layerController.insertMarker(0);
    notifyListeners();
  }

  Future getDeforattionData() async {
    var uri = Uri.parse('http://127.0.0.1:8000/defor');
    final res = await http.get(uri, headers: {'accept': 'application/json'});
    dataTX = DeforCall.fromJson(json.decode(res.body));
    notifyListeners();
  }

  Future getImageA() async {
    var uri = Uri.parse('http://127.0.0.1:8000/getlabel');
    final res = await http.get(uri, headers: {'accept': 'application/json'});
    dataAnl = json
        .decode(res.body)
        .map<ImageAnalysic>((e) => ImageAnalysic.fromJson(e))
        .toList();
    notifyListeners();
  }

  String dashImg = '';
  String dashtext = '';

  void getImage(String ima, String t) {
    dashImg = ima;
    dashtext = t;
    notifyListeners();
  }

  List<String> placeName = [
    "Para",
    "Mato Grosso",
    "Rondonia",
    "Amazonas",
    "Maranhao",
    "Acre",
    "Roraima",
    "Amapa",
    "Tocantis"
  ];

  void changeDropDownPlace(String s) {
    placeSelectedValue = s;
    predict();
    notifyListeners();
  }

  void changeDayvalue(double s) {
    initalDay = s;
    notifyListeners();
  }

  void changeMonthvalue(double s) {
    initalMonth = s;
    notifyListeners();
  }

  void changeYearvalue(double s) {
    initalYear = s;
    notifyListeners();
  }

  @override
  void dispose() {
    layerController.dispose();
    super.dispose();
  }
}
