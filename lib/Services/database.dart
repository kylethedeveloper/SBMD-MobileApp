import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_baby_monitoring_device/Models/alertLimitsData.dart';
import 'package:smart_baby_monitoring_device/Models/alertsData.dart';
import 'package:smart_baby_monitoring_device/Models/logsData.dart';
import 'package:smart_baby_monitoring_device/Models/userData.dart';

class DatabaseService {
	
	final String uid;
	
	DatabaseService({this.uid});
	
	// collection reference
	final CollectionReference usersCollection = Firestore.instance.collection('users');
	
	Future createUserData(String email, bool setup, int music, DateTime connection, bool monitoringMode,
			int tempBelow, int tempAbove, int humidBelow, int humidAbove, bool liveStream) async {
		return await usersCollection.document(uid).setData({
			'mail': email,
			'setup': setup,
			'music': music,
			'connection': connection,
			'monitoringMode': monitoringMode,
			'tempBelow': tempBelow,
			'tempAbove': tempAbove,
			'humidBelow': humidBelow,
			'humidAbove': humidAbove,
			'liveStream' : liveStream
		});
	}
	
	// function to change email
	Future changeEmail(String email) async {
		return await usersCollection.document(uid).setData({
			'mail': email,
		}, merge: true);
	}
	
	// function to change music
	Future changeMusic(int music) async {
		return await usersCollection.document(uid).setData({
			'music': music,
		}, merge: true);
	}
	
	// function to reset setup
	Future resetSetup(bool setup) async {
		return await usersCollection.document(uid).setData({
			'setup': setup,
		}, merge: true);
	}
	
	// function to change monitoring mode
	Future changeMonitoring(bool monitoring) async {
		return await usersCollection.document(uid).setData({
			'monitoringMode': monitoring,
		}, merge: true);
	}
	
	// function to change live stream
	Future changeLiveStream(bool live) async {
		return await usersCollection.document(uid).setData({
			'liveStream' : live,
		}, merge: true);
	}
	
	// function to clear logs
	Future clearLogs() async {
		return await usersCollection.document(uid).collection('logs').getDocuments().then((snapshot) {
			for (DocumentSnapshot docs in snapshot.documents) {
				docs.reference.delete();
			}
		});
	}
	
	// function to clear alerts
	Future clearAlerts() async {
		return await usersCollection.document(uid).collection('alerts').getDocuments().then((snapshot) {
			for (DocumentSnapshot docs in snapshot.documents) {
				docs.reference.delete();
			}
		});
	}
	
	// function to set temp below
	Future setTempBelow([int tempBelow = -99]) async {
		return await usersCollection.document(uid).setData({
			'tempBelow': tempBelow,
		}, merge: true);
	}
	
	// function to set temp above
	Future setTempAbove([int tempAbove = -99]) async {
		return await usersCollection.document(uid).setData({
			'tempAbove': tempAbove,
		}, merge: true);
	}
	
	// function to set humid below
	Future setHumidBelow([int humidBelow = -99]) async {
		return await usersCollection.document(uid).setData({
			'humidBelow': humidBelow,
		}, merge: true);
	}
	
	// function to set humid above
	Future setHumidAbove([int humidAbove = -99]) async {
		return await usersCollection.document(uid).setData({
			'humidAbove': humidAbove,
		}, merge: true);
	}
	
	// alert limits data from snapshot
	AlertLimitsData _alertLimitsFromSnapshot(DocumentSnapshot snapshot) {
		return AlertLimitsData(
				tempBelow: snapshot.data['tempBelow'],
				tempAbove: snapshot.data['tempAbove'],
				humidBelow: snapshot.data['humidBelow'],
				humidAbove: snapshot.data['humidAbove'],
		);
	}
	
	// alert limits data from snapshot
	Stream<AlertLimitsData> get alertsLimitsData {
		return usersCollection.document(uid).snapshots().map(_alertLimitsFromSnapshot);
	}
	
	// user data from snapshot
	UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
		return UserData(
				temp: snapshot.data['temp'] ?? 'No Data',
				humid: snapshot.data['humid'] ?? 'No Data',
				monitoringMode: snapshot.data['monitoringMode'] ?? false,
				connection: snapshot.data['connection'],
				setup: snapshot.data['setup'] ?? false,
				music: snapshot.data['music'] ?? 0,
				liveStream: snapshot.data['liveStream'] ?? false,
		);
	}
	
	// get user's data stream
	Stream<UserData> get userData {
		return usersCollection.document(uid).snapshots().map(_userDataFromSnapshot);
	}
	
	// logs data from snapshot
	List<LogsData> _logsDataFromSnapshot(QuerySnapshot snapshot) {
		return snapshot.documents.map((doc) {
			return LogsData(
					humid: doc.data['humid'] ?? '0',
					temp: doc.data['temp'] ?? '0',
					date: doc.data['date'] ?? '0'
			);
		}).toList();
	}
	
	// get logs data stream
	Stream<List<LogsData>> get logsData {
		return usersCollection.document(uid).collection('logs').orderBy("date", descending: true).snapshots()
				.map(_logsDataFromSnapshot);
	}
	
	// alerts data from snapshot
	List<AlertsData> _alertsDataFromSnapshot(QuerySnapshot snapshot) {
		return snapshot.documents.map((doc) {
			return AlertsData(
					alert: doc.data['alert'] ?? 'No alert',
					date: doc.data['date'] ?? '0'
			);
		}).toList();
	}
	
	// get alerts data stream
	Stream<List<AlertsData>> get alertsData {
		return usersCollection.document(uid).collection('alerts').orderBy("date", descending: true).snapshots()
				.map(_alertsDataFromSnapshot);
	}
	
}