import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_baby_monitoring_device/Models/user.dart';
import 'package:smart_baby_monitoring_device/Services/database.dart';

class AuthService {
	final FirebaseAuth _auth = FirebaseAuth.instance;
	
	// Create user object based on FirebaseUser
	User _userFromFirebaseUser(FirebaseUser user) {
		if (user != null) {
			return User(uid: user.uid); // getting the uid and isEmailVerified properties
		}
		else {
			return null;
		}
	}
	
	// auth change user stream
	Stream<User> get user {
		return _auth.onAuthStateChanged.map((FirebaseUser user) => _userFromFirebaseUser(user));
		//.map(_userFromFirebaseUser(user));  // does exactly the same with the previous line
	}
	
	// Sign in anonymously
	Future signInAnon() async {
		try {
			AuthResult result = await _auth.signInAnonymously(); // get the result
			FirebaseUser user = result.user; // write the result to the FirebaseUser user
			return _userFromFirebaseUser(user); // return the custom created user object
		}
		catch (e) {
			print(e.toString());
			return null;
		}
	}

// Log out
	Future signOut() async {
		try {
			return await _auth.signOut();
		}
		catch (e) {
			print(e.toString());
			return null;
		}
	}

// Register with email&pass
	
	Future signUp(String email, String password) async {
		try {
			AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
			FirebaseUser user = result.user;
			
			// create a new user data for this user
			await DatabaseService(uid: user.uid).createUserData(email, false, 0);
			
			return _userFromFirebaseUser(user);
		}
		catch (e) {
			print(e.message);
			return null;
		}
	}

// Sign in with email&pass
	Future signIn(String email, String password) async {
		try {
			AuthResult result = await FirebaseAuth.instance
					.signInWithEmailAndPassword(email: email, password: password);
			FirebaseUser user = result.user;
			return _userFromFirebaseUser(user);
		}
		catch (e) {
			print(e.message);
			return null;
		}
	}

//  Future<void> signUp() async {
//    final formState = _formKey.currentState;
//    if (formState.validate()) {
//      formState.save(); // save email and password variables
//      try {
//        AuthResult user = await FirebaseAuth.instance
//            .createUserWithEmailAndPassword(email: _email, password: _password);
//        Navigator.of(context).pop();
//        Navigator.pushReplacement(
//            context, MaterialPageRoute(builder: (context) => LoginPage()));
//      } catch (e) {
//        print(e.message);
//      }
//    }
//  }

}
