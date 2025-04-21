import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends CoreCubit<AuthState> {
  AuthCubit() : super(const AuthState());
}
