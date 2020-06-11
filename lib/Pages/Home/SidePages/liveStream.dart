import 'package:flutter/material.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';
import 'package:smart_baby_monitoring_device/Services/database.dart';
import 'package:video_player/video_player.dart';
//import 'package:flutter_hooks/flutter_hooks.dart';

class LiveStream extends StatefulWidget {
	
	final uid;
	
	LiveStream({Key key, @required this.uid}) : super(key: key);
	
	@override
	_LiveStreamState createState() => _LiveStreamState(uid: uid);
}

class _LiveStreamState extends State<LiveStream> {
	
	final uid;
	_LiveStreamState({this.uid});
	
	//VlcPlayerController _liveController;
	//Future<void> _initializeVideoPlayer;
	
	final String _url = "STREAM_URL";
	// HIDE: the link
	
	bool demo = false;
	bool isLive = true;
	
	VideoPlayerController _controller;
	Future<void> _initializeVideoPlayerFuture;
	
	@override
	void initState() {
		_controller = VideoPlayerController.asset("lib/Assets/baby-escape.mp4");
		
		// Initialize the controller and store the Future for later use.
		_initializeVideoPlayerFuture = _controller.initialize();
		
		// Use the controller to loop the video.
		_controller.setLooping(true);
		
		super.initState();
	}
	
	@override
	void disposePlayer() {
		// Ensure disposing of the VideoPlayerController to free up resources.
		_controller.dispose();
	}
	
	@override
	Widget build(BuildContext context) {
		//final isRunning = useState(true);
		final Orientation orientation = MediaQuery
				.of(context)
				.orientation;
		final bool isLandscape = orientation == Orientation.landscape;
		
		return WillPopScope(
			onWillPop: _back,
			child: Scaffold(
				//backgroundColor: Colors.black,
				primary: !isLandscape,
				appBar: AppBar(
					backgroundColor: Colors.mySpecialGreen,
					title: Text("Live View"),
					centerTitle: true,
					leading: IconButton(
						icon: Icon(Icons.arrow_back),
						onPressed: _back,
					),
					actions: <Widget>[
						FlatButton.icon(
							onPressed: _createCameraImage,
							textColor: Colors.white,
							icon: Icon(Icons.photo_camera),
							label: Text("Snap"),
						)
					],
				),
				body: Center(
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						crossAxisAlignment: CrossAxisAlignment.center,
						children: <Widget>[
							Container(
									decoration: BoxDecoration(
										border: Border.all(
											color: Colors.black,
											style: BorderStyle.solid,
										),
										borderRadius: BorderRadius.circular(2),
									),
									child: !demo
											? Mjpeg(
										height: 300,
										width: 400,
										stream: _url,
										isLive: isLive,
										loading: (BuildContext loadingContext) {
											return Container(
													height: 250,
													child: Row(
														mainAxisAlignment: MainAxisAlignment.center,
														children: <Widget>[
															CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.mySpecialGreen),),
														],
													)
											);
										},
									)
											: FutureBuilder(
										future: _initializeVideoPlayerFuture,
										builder: (context, snapshot) {
											if (snapshot.connectionState == ConnectionState.done) {
												// if loaded
												return AspectRatio(
													aspectRatio: _controller.value.aspectRatio,
													child: VideoPlayer(_controller),
												);
											}
											else {
												// while loading
												return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.mySpecialGreen)));
											}
										},
									)
							),
							Row(
								mainAxisAlignment: MainAxisAlignment.center,
								crossAxisAlignment: CrossAxisAlignment.center,
								children: <Widget>[
									Text(
										"Demo Mode ",
										style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
									),
									Switch.adaptive(
											activeColor: Colors.mySpecialGreen,
											value: demo,
											onChanged: (val) {
												setState(() {
													demo = val;
													if (val) {
														_controller.play();
														isLive = !val;
													}
													else
														_controller.pause();
														_controller.seekTo(Duration(minutes: 0));
														isLive = !val;
												});
											}
									), // demo switch
								],
							)
						
						
						],
					),
				),
			),
		);
	}
	
	Future<bool> _back() async {
		await DatabaseService(uid: uid).changeLiveStream(false);
		//disposePlayer();
		Navigator.pop(context);
	}
	
	void _createCameraImage() async {
		//TODO: Take a snapshot and save
	}

/*	void _play() {
		print(_liveController.initialized);
		if (_liveController.initialized) {
			_liveController.play();
		}
	}*/
	
	
}

/*SizedBox(
					  				width: 400,
					  				height: 300,
					  				child: new VlcPlayer(
					  					url: _url,
					  					controller: _liveController,
					  					aspectRatio: 4 / 3,
					  					placeholder: Container(
					  							height: 250,
					  							child: Row(
					  								mainAxisAlignment: MainAxisAlignment.center,
					  								children: <Widget>[
					  									CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.mySpecialGreen),),
					  								],
					  							)
					  					),
					  				),
					  			),*/


/*RaisedButton.icon(
onPressed: _play,
icon: Icon(Icons.play_circle_outline),
label: Text("Click to watch", style: TextStyle(fontSize: 22),)),*/

/*FutureBuilder(
					  			future: _initializeVideoPlayer,
					  			builder: (context, snapshot) {
					  				print(snapshot.error);
					  				print(_initializeVideoPlayer);
					  				if (snapshot.connectionState == ConnectionState.done) {
					  					print("ConnectionState DONE");
					  					print(_liveController.initialized);
					  					return SizedBox(
					  						width: 400,
					  						height: 300,
					  						child: new VlcPlayer(
					  							url: _url,
					  							controller: _liveController,
					  							aspectRatio: 4 / 3,
					  							placeholder: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.mySpecialGreen),),),
					  						),
					  					);
					  				}
					  				else {
					  					print("ConnectionState ????");
					  					print(_liveController.initialized);
					  					return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.mySpecialGreen),),);
					  				}
					  			},
					  		),*/