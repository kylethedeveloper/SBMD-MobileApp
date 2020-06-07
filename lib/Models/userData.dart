
// user's data class

import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
	
	final String temp;
	final String humid;
	final bool monitoringMode;
	final bool setup;
	final int music;
	final Timestamp connection;
	final bool liveStream;
	
	UserData({ this.temp, this. humid, this.monitoringMode, this.setup, this.music, this.connection, this.liveStream });
	
}
