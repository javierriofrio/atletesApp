import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:atletes_sport_app/constants.dart';
import 'package:atletes_sport_app/user/model/user.dart';
import 'package:atletes_sport_app/event/model/event.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireStoreUtils {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;

  static Future<User?> getCurrentUser(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> userDocument =
        await firestore.collection(USERS).doc(uid).get();
    if (userDocument.data() != null && userDocument.exists) {
      return User.fromJson(userDocument.data()!);
    } else {
      return null;
    }
  }

  static Future<Event?> getCurrentEvent(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> userDocument =
    await firestore.collection(EVENTS).doc(uid).get();
    if (userDocument.data() != null && userDocument.exists) {
      return Event.fromJson(userDocument.data()!);
    } else {
      return null;
    }
  }

  static Future<User> updateCurrentUser(User user) async {
    return await firestore
        .collection(USERS)
        .doc(user.userID)
        .set(user.toJson())
        .then((document) {
      return user;
    });
  }

  static loginWithFacebook() async {
    FacebookAuth facebookAuth = FacebookAuth.instance;
    bool isLogged = await facebookAuth.accessToken != null;
    if (!isLogged) {
      LoginResult result = await facebookAuth
          .login(); // by default we request the email and the public profile
      if (result.status == LoginStatus.success) {
        // you are logged
        AccessToken? token = await facebookAuth.accessToken;
        return await handleFacebookLogin(
            await facebookAuth.getUserData(), token!);
      }
    } else {
      AccessToken? token = await facebookAuth.accessToken;
      return await handleFacebookLogin(
          await facebookAuth.getUserData(), token!);
    }
  }

  static handleFacebookLogin(
      Map<String, dynamic> userData, AccessToken token) async {
    auth.UserCredential authResult = await auth.FirebaseAuth.instance
        .signInWithCredential(
            auth.FacebookAuthProvider.credential(token.token));
    User? user = await getCurrentUser(authResult.user?.uid ?? '');
    List<String> fullName = (userData['name'] as String).split(' ');
    String firstName = '';
    String lastName = '';
    if (fullName.isNotEmpty) {
      firstName = fullName.first;
      lastName = fullName.skip(1).join(' ');
    }

    return await createUserFacebook(user, userData, firstName, lastName, authResult);
  }

  static loginWithGoogle() async {

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = auth.GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    auth.UserCredential authResult  =await auth.FirebaseAuth.instance.signInWithCredential(credential);

    User? user = await getCurrentUser(authResult.user?.uid ?? '');
    List<String> fullName = authResult.user!.displayName!.split(' ');
    String firstName = '';
    String lastName = '';
    if (fullName.isNotEmpty) {
      firstName = fullName.first;
      lastName = fullName.skip(1).join(' ');
    }

    return await createUserGoogle(user, firstName, lastName, authResult);
  }

  static Future<dynamic> createUserGoogle (User? user, String firstName, String lastName, auth.UserCredential authResult) async {
    user = User(
        email: authResult.user!.emailVerified.toString(),
        firstName: firstName,
        lastName: lastName,
        profilePictureURL: authResult.user!.photoURL.toString(),
        userID: authResult.user!.uid
    );
    String? errorMessage = await createNewUser(user);
    if (errorMessage == null) {
      return user;
    } else {
      return errorMessage;
    }
  }

  static Future<dynamic> createUserFacebook(User? user, Map<String, dynamic> userData, String firstName, String lastName, auth.UserCredential authResult) async {
    if (user != null) {
      user.profilePictureURL = userData['picture']['data']['url'];
      user.firstName = firstName;
      user.lastName = lastName;
      user.email = userData['email'];
      dynamic result = await updateCurrentUser(user);
      return result;
    } else {
      user = User(
          email: userData['email'] ?? '',
          firstName: firstName,
          lastName: lastName,
          profilePictureURL: userData['picture']['data']['url'] ?? '',
          userID: authResult.user?.uid ?? '');
      String? errorMessage = await createNewUser(user);
      if (errorMessage == null) {
        return user;
      } else {
        return errorMessage;
      }
    }
  }

  /// save a new user document in the USERS table in firebase firestore
  /// returns an error message on failure or null on success
  static Future<String?> createNewUser(User user) async => await firestore
      .collection(USERS)
      .doc(user.userID)
      .set(user.toJson())
      .then((value) => null, onError: (e) => e);

  static Future<String?> createNewEvent(Event event) async => await firestore
      .collection(EVENTS)
      .doc()
      .set(event.toJson())
      .then((value) => null, onError: (e) => e);

  static logout() async {
    await auth.FirebaseAuth.instance.signOut();
  }

  static Future<String?> createNewEventUser(Event event, String userId) async => await firestore
      .collection(USERS).doc().collection(EVENTS)
      .doc()
      .set(event.toJson())
      .then((value) => null, onError: (e) => e);

  static Future<User?> getAuthUser() async {
    auth.User? firebaseUser = auth.FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      User? user = await getCurrentUser(firebaseUser.uid);
      return user;
    } else {
      return null;
    }
  }

}
