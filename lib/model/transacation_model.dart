
class TransacationModel {
  final String id ;
  final String timestamp;
  final String option;
  final String inputCsvUrl;
  final String outputCsvUrl;
  final String label;

  TransacationModel({
    required this.id,
    required this.timestamp,
    required this.option,
    required this.inputCsvUrl,
    required this.outputCsvUrl,
    required this.label,
  });

  factory TransacationModel.fromJson(Map<String, dynamic> json) {
    return TransacationModel(
      id: json['id'] ?? '',
      timestamp: json['timestamp'] ?? '',
      option: json['option'] ?? '',
      inputCsvUrl: json['inputCsvUrl'] ?? '',
      outputCsvUrl: json['outputCsvUrl'] ?? '',
      label: json['label'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
      'id' :id,
      'option': option,
      'inputCsvUrl': inputCsvUrl,
      'outputCsvUrl': outputCsvUrl,
      'label': label,
    };
  }

}
