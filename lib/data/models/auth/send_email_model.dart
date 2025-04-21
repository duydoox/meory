class SendEmailModel {
  final String? tokenOTP;

  const SendEmailModel({
    this.tokenOTP,
  });
  factory SendEmailModel.fromJson(Map<String, dynamic> json) {
    return SendEmailModel(
      tokenOTP: json['tokenOTP'] as String?,
    );
  }

  SendEmailModel copyWith({
    String? tokenOTP,
  }) {
    return SendEmailModel(
      tokenOTP: tokenOTP ?? this.tokenOTP,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "tokenOTP": tokenOTP,
    };
  }
}
