import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meory/presentations/routes.dart';

part 'auth_state.dart';

class AuthCubit extends CoreCubit<AuthState> {
  AuthCubit() : super(const AuthState());

  Future<void> onTapSignInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final googleAuth = await googleUser!.authentication;

      debugPrint('👤 Tên: ${googleUser.displayName}');
      debugPrint('📧 Email: ${googleUser.email}');
      debugPrint('🆔 ID: ${googleUser.id}');
      debugPrint('🖼️ Ảnh: ${googleUser.photoUrl}');

      debugPrint('🔑 ID Token: ${googleAuth.idToken}');
      debugPrint('🔒 Access Token: ${googleAuth.accessToken}');

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        AppNavigator.go(Routes.home);
      }
    } catch (error) {
      debugPrint('⚠️ Lỗi: $error');
    }
  }
}
