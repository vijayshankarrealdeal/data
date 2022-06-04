class ImageAnalysic {
  ImageAnalysic({
    required this.predict,
    required this.img,
  });
  late final String predict;
  late final String img;

  ImageAnalysic.fromJson(Map<String, dynamic> json) {
    predict = json['predict'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['predict'] = predict;
    data['img'] = img;
    return data;
  }


}
