import 'package:core/core.dart';

class OtpState extends CoreState {
  final bool verifying;
  const OtpState({
    bool isLoading = false,
    String errorMessage = '',
    this.verifying = true,
  }) : super(
          isLoading: isLoading,
          errorMessage: errorMessage,
        );

  @override
  OtpState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? verifying,
  }) {
    return OtpState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      verifying: verifying ?? this.verifying,
    );
  }

  @override
  List<Object?> get props => [
        verifying,
        isLoading,
        errorMessage,
      ];
}
