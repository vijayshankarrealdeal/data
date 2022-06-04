class Coordinate {
  final String year;
  final double rates;
  Coordinate({required this.year, required this.rates});
  factory Coordinate.fromJson(Map<String, dynamic> data) {
    return Coordinate(year: data['year'], rates: data['rates'].toDouble());
  }
}

class DeforCall {
  final List<Coordinate> para;
  final List<Coordinate> matogrosso;
  final List<Coordinate> rondonia;
  final List<Coordinate> amazonas;
  final List<Coordinate> maranhao;
  final List<Coordinate> acre;
  final List<Coordinate> roraima;
  final List<Coordinate> amapa;
  final List<Coordinate> tocantis;

  DeforCall(
      {required this.acre,
      required this.amapa,
      required this.amazonas,
      required this.rondonia,
      required this.matogrosso,
      required this.maranhao,
      required this.para,
      required this.roraima,
      required this.tocantis});

  factory DeforCall.fromJson(Map<String, dynamic> data) {
    return DeforCall(
      rondonia:List.from(data['rondonia']).map((e) => Coordinate.fromJson(e)).toList(),
      acre: List.from(data['acre']).map((e) => Coordinate.fromJson(e)).toList(),
      amapa:
          List.from(data['amapa']).map((e) => Coordinate.fromJson(e)).toList(),
      amazonas: List.from(data['amazonas'])
          .map((e) => Coordinate.fromJson(e))
          .toList(),
      matogrosso: List.from(data['mato grosso'])
          .map((e) => Coordinate.fromJson(e))
          .toList(),
      maranhao: List.from(data['maranhao'])
          .map((e) => Coordinate.fromJson(e))
          .toList(),
      para: List.from(data['para']).map((e) => Coordinate.fromJson(e)).toList(),
      roraima: List.from(data['roraima'])
          .map((e) => Coordinate.fromJson(e))
          .toList(),
      tocantis: List.from(data['tocantis'])
          .map((e) => Coordinate.fromJson(e))
          .toList(),
    );
  }
}
