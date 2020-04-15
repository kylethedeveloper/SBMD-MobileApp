import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_baby_monitoring_device/Models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //TODO: Create user object based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    if (user != null){
      return User(uid: user.uid, isEmailVerified: user.isEmailVerified);  // getting the uid and isEmailVerified properties
    } else {
      return null;
    }
  }

  //TODO: Sign in with email&pass

  //TODO: Sign in anon
  Future signInAnon() async {
    try{
      AuthResult result = await _auth.signInAnonymously();  // get the result
      FirebaseUser user = result.user;                      // write the result to the FirebaseUser user
      return _userFromFirebaseUser(user);                   // return the custom created user object
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  //TODO: Log out

  //TODO: Register with email&pass

}
