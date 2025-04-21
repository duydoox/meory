class VerifyOtpModel {
  final String? tokenVerifyOTP;

  const VerifyOtpModel({
    this.tokenVerifyOTP,
  });
  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpModel(
      tokenVerifyOTP: json['tokenVerifyOTP'] as String?,
    );
  }
  VerifyOtpModel copyWith({
    String? tokenVerifyOTP,
  }) {
    return VerifyOtpModel(
      tokenVerifyOTP: tokenVerifyOTP ?? this.tokenVerifyOTP,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "tokenVerifyOTP": tokenVerifyOTP,
    };
  }
}
