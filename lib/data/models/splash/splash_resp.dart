class SplashResp {
  final String? title;

  const SplashResp({this.title});

  factory SplashResp.fromJson(Map<String, dynamic> json) => SplashResp(
        title: json['title'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
      };
}
