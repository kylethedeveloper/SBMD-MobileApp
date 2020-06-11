
// "alert limits of the users" class

import 'package:cloud_firestore/cloud_firestore.dart';

class AlertLimitsData {
	
	final int tempBelow;
	final int tempAbove;
	final int humidBelow;
	final int humidAbove;
	final List forbiddenZone;
	final Timestamp connection;
	
	AlertLimitsData({ this.tempBelow, this.tempAbove, this.humidBelow, this.humidAbove, this.forbiddenZone, this.connection });
	
}