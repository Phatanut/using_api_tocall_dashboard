class RainfallThai {
  final String toID;
  final String ProvinceName;
  final String EngName;
  final String MinRain;
  final String MaxRain;
  final String AvgRain;
  final String region;
  final String Year;
  final String Month;
  final String Date;
  final String MonThai;
  RainfallThai({
    required this.toID,
    required this.ProvinceName,
    required this.EngName,
    required this.MinRain,
    required this.MaxRain,
    required this.AvgRain,
    required this.region,
    required this.Year,
    required this.Month,
    required this.Date,
    required this.MonThai,
  });
  factory RainfallThai.fromJson(Map<String, dynamic> json) => RainfallThai(
        toID: json["toID"],
        ProvinceName: json["ProvinceName"],
        EngName: json["EngName"],
        MinRain: json["MinRain"],
        MaxRain: json["MaxRain"],
        AvgRain: json["AvgRain"],
        region: json["region"],
        Year: json["Year"],
        Month: json["Month"],
        Date: json["Date"],
        MonThai: json["MonThai"],
      );
  Map<String, dynamic> toJson() => {
        "toID": toID,
        "ProvinceName": ProvinceName,
        "EngName": EngName,
        "MinRain": MinRain,
        "MaxRain": MaxRain,
        "AvgRain": AvgRain,
        "region": region,
        "Year": Year,
        "Month": Month,
        "Date": Date,
        "MonThai": MonThai,
      };
}
