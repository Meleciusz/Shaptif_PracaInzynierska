import 'dart:async';
import 'package:authorization_repository/authorization_repository.dart';
import 'package:cache/cache.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';


//class that describes operations when signing up with email and password have failure detected
class SignUpWithEmailAndPasswordFailure implements Exception {
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'Unknown error has occurred.',
  ]);

  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure('Email is not valid');
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
            'Email is already in use');
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
            'Password is not strong enough');
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure('Operation not allowed');
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
  final String message;
}

//class that describes operations when signing with google have failure detected
class SignInWithGoogleFailure implements Exception {
  const SignInWithGoogleFailure([
    this.message = 'Unknown error has occurred.',
  ]);

  factory SignInWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const SignInWithGoogleFailure('Account exists with different credential.');
      case 'invalid-credential':
        return const SignInWithGoogleFailure('The credential may be expired.');
      case 'operation-not-allowed':
        return const SignInWithGoogleFailure('Operation not allowed.');
      case 'user-disabled':
        return const SignInWithGoogleFailure('User disabled.');
      case 'user-not-found':
        return const SignInWithGoogleFailure('User not found.');
      case 'wrong-password':
        return const SignInWithGoogleFailure('Wrong password.');
      case 'invalid-verification-code':
        return const SignInWithGoogleFailure('Invalid verification code.');
      case 'invalid-verification-id':
        return const SignInWithGoogleFailure('Invalid verification ID.');
      default:
        return const SignInWithGoogleFailure();
    }
  }

  final String message;
}

//class that describes operations when logging out have failure detected
class LogOutFailure implements Exception {
  const LogOutFailure([
    this.message = 'Unknown error has occurred.',
  ]);

  factory LogOutFailure.fromCode(String code) {
    switch (code) {
      default:
        return const LogOutFailure();
    }
  }

  final String message;
}

class AuthorizationRepository {
  AuthorizationRepository({

    //cache that is used to store the current user
    CacheClient? cache,

    //firebase authentication instance
    firebase_auth.FirebaseAuth? firebaseAuth,

    //google sign in instance
    GoogleSignIn? googleSignIn,
    }) : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final CacheClient _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  @visibleForTesting
  static const String userCacheKey = '__user_cache_key__';

  //This stream will emit the current user when the authentication state changes
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser){
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      _cache.writeToMemoryCache(key: userCacheKey, data: user);
      return user;
    });
  }

  //Returns the current cached user
  User get currentUser {
    return _cache.readFromMemoryCache(key: userCacheKey) ?? User.empty;
  }

  //Create a new user with the provided email and password function
  Future<void> signUpWithEmailAndPassword({
    required String email, required String password,
  }) async{
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    }catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
      }
    }

    //log in with google function
  Future<void> logInWithGoogle() async {
    try {
      late final firebase_auth.AuthCredential credential;
      if(kIsWeb){
        final googleProvider = firebase_auth.GoogleAuthProvider();
        final userCredential = await _firebaseAuth.signInWithPopup(googleProvider);
        credential = userCredential.credential!;
      }else{
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        credential = firebase_auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      }
      await _firebaseAuth.signInWithCredential(credential);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignInWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      throw const SignInWithGoogleFailure();
    }
  }

  //log in with email and password function
  Future<void> logInWithEmailAndPassword ({
    required String email,
    required String password,
}) async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignInWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      throw const SignInWithGoogleFailure();
    }
  }

  //Signs out the current user
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    }catch (_) {
      throw LogOutFailure();
    }
  }
}

//Converts a firebase authorization user to a user defines by the user model
extension on firebase_auth.User {
  User get toUser{
    return User(
        id: uid,
        email: email,
        name: displayName,
        photo: photoURL
    );
  }
}