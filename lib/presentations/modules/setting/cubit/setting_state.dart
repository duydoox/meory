part of 'setting_cubit.dart';

class SettingState extends CoreState {
  const SettingState({
    bool isLoading = false,
    String errorMessage = '',
  }) : super(
          isLoading: isLoading,
          errorMessage: errorMessage,
        );

  @override
  SettingState copyWith({
    bool? isLoading,
    String? errorMessage,
  }) {
    return SettingState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
      ];
}
