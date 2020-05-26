import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_baby_monitoring_device/Models/userData.dart';

class DatabaseService {
	
	// TODO: Add timestampt
	
	final String uid;
	
	DatabaseService({this.uid});
	
	// collection reference
	final CollectionReference usersData = Firestore.instance.collection('users');
	
	Future createUserData(String email, bool setup, int music) async {
		return await usersData.document(uid).setData({
			'mail': email,
			'setup': setup,
			'music': music
		});
	}
	
	Future changeEmail(String email) async {
		return await usersData.document(uid).setData({
			'mail': email,
		}, merge: true);
	}
	
	Future changeMusic(int music) async {
		return await usersData.document(uid).setData({
			'music': music,
		}, merge: true);
	}
	
	// sensors data from snapshot
	UserData _sensorsFromSnapshot(DocumentSnapshot snapshot) {
		return UserData(
				temp: snapshot.data['temp'],
				humid: snapshot.data['humid'],
				setup: snapshot.data['setup'],
				music: snapshot.data['music']
		);
	}
	
	// get users' data stream
	Stream<UserData> get userData {
		return usersData.document(uid).snapshots().map(_sensorsFromSnapshot);
	}
	
}