import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kit_chat_app/domain/models/user_model.dart';
import 'package:kit_chat_app/domain/repositories/authencation_repository.dart';

class FirebaseAuthencationRepository implements AuthencationRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  @override
  Future<UserModel> getUser() async {
    final userId = _firebaseAuth.currentUser?.uid ?? '';
    final value = await _fireStore.collection('users').doc(userId).get();
    final result = value.data();
    final userModel = UserModel.fromJson(result ?? {});
    return userModel;
  }

  @override
  Future<void> logInWithSocial(AuthencationType type) async {
    if (type == AuthencationType.facebook) {
    } else if (type == AuthencationType.google) {
      await signInWithGoogle();
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        log('Sign in success');
        final GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;

        final String accessToken = googleAuth.accessToken ?? '';

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: accessToken,
        );
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        await addUserToDatabase(userCredential);
      } else {
        log('Sign in fail');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> addUserToDatabase(UserCredential userCredential) async {
    final user = userCredential.user;
    final userModel = UserModel(
      friends: [],
      userId: user?.uid,
      username: user?.displayName ?? '',
      email: user?.email ?? '',
      avatarUrl: user?.photoURL ?? '',
      status: Status.offline,
    );

    final value = await _fireStore.collection('users').doc(user?.uid).get();
    if (!value.exists) {
      await _fireStore.collection('users').doc(user?.uid).set(
            userModel.toJson(),
          );
    } else {
      await _fireStore
          .collection('users')
          .doc(user?.uid)
          .update(value.data() as Map<Object, Object>);
    }
    log('User model: ${userModel.toJson()}');
  }

  @override
  Future<void> logOut() async {
    _firebaseAuth.signOut();
  }
}
