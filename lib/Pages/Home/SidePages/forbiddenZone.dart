import 'package:flutter/material.dart';
import 'package:smart_baby_monitoring_device/Services/database.dart';
import 'package:flutter_image/network.dart';

class ForbiddenZone extends StatefulWidget {
	
	final uid;
	ForbiddenZone({@required this.uid});
	
	@override
	_ForbiddenZoneState createState() => _ForbiddenZoneState(uid: uid);
}

class _ForbiddenZoneState extends State<ForbiddenZone> {
	
	final uid;
	_ForbiddenZoneState({this.uid});
	
	final String _img = "IMG_URL";
	
	// HIDE: the link
	final String _img2 = "https://images.pexels.com/photos/53621/calculator-calculation-insurance-finance-53621.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
	String _img3;
	
	List fin;
	
	bool demo = false;
	
	Future<bool> _back() async {
		await DatabaseService(uid: uid).changeLiveStream(false);
		Navigator.pop(context);
	}
	
	@override
	Widget build(BuildContext context) {
		return WillPopScope(
			onWillPop: _back,
			child: Scaffold(
					appBar: AppBar(
						backgroundColor: Colors.mySpecialGreen,
						title: Text("Set the forbidden zone"),
						centerTitle: true,
						leading: IconButton(
							icon: Icon(Icons.arrow_back),
							onPressed: _back,
						),
					),
					body: Center(
						child: Column(
							mainAxisAlignment: MainAxisAlignment.center,
							crossAxisAlignment: CrossAxisAlignment.center,
							children: <Widget>[
								Padding(
									padding: const EdgeInsets.only(bottom: 24),
									child: Text(
										"You can move & resize the rectangle freely.\n Then click the button to set the forbidden zone.",
										style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.mySpecialGreen),
										textAlign: TextAlign.center,
									),
								), // description
								Container(
									width: 405,
									height: 305,
									decoration: BoxDecoration(
										border: Border.all(
											color: Colors.black,
											style: BorderStyle.solid,
										),
										borderRadius: BorderRadius.circular(2),
									),
									child: Stack(
											children: <Widget>[
												Center(
													child: Image(
														// TODO: if not loaded
														image: demo
																? AssetImage(
															"lib/Assets/baby-forbiddenzone.png"
														)
																: NetworkImageWithRetry(
															_img,
														),
														width: 400,
														height: 300,
														loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
															if (loadingProgress == null) return child;
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
													),
												),
												ResizableWidget(
													finRectangle: (List fin) =>
															setState(() {
																this.fin = fin; // retrieve this!
															}),
												)
											]
									),
								), // image
								ButtonTheme(
									minWidth: 150,
									shape: RoundedRectangleBorder(
											borderRadius: BorderRadius.circular(14.0)
									),
									child: RaisedButton.icon(
										textColor: Colors.white,
										icon: Icon(Icons.check_circle),
										color: Colors.red[800],
										label: Text("SET", style: TextStyle(fontSize: 20, color: Colors.white),),
										onPressed: () async {
											await DatabaseService(uid: uid).setForbiddenZone(fin);
											await DatabaseService(uid: uid).changeLiveStream(false);
											Navigator.pop(context);
										},
									),
								), // set button
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
													});
												}
										),
									],
								) // demo switch
							],
						),
					)
			),
		);
	}
}

Widget myImage() {

}

class ResizableWidget extends StatefulWidget {
	ResizableWidget({this.finRectangle, this.child});
	
	final Function(List) finRectangle;
	final Widget child;
	
	@override
	_ResizableWidgetState createState() => _ResizableWidgetState();
}

const ballDiameter = 18.0;

class _ResizableWidgetState extends State<ResizableWidget> {
	
	double height = 150;
	double width = 150;
	
	double left = 125; // x1
	double top = 75; // y1
	int right = 275; // x2
	int bottom = 225; // y2
	
	void onDrag(double dx, double dy) {
		var newHeight = height + dy;
		var newWidth = width + dx;
		
		setState(() {
			height = newHeight > 0 ? newHeight : 0;
			width = newWidth > 0 ? newWidth : 0;
		});
	}
	
	bool checkHorizontalSideLimit(double t, int b) {
		if (t > 0 && b < 300)
			return true;
		else
			return false;
	}
	
	bool checkVerticalSideLimit(double l, int r) {
		if (l > 0 && r <= 400)
			return true;
		else
			return false;
	}
	
	List returnThis(double l, double t, int r, int b) {
		int x1 = l.round();
		int y1 = t.round();
		int x2 = r;
		int y2 = b;
		List fin = [x1, y1, x2, y2];
		return fin;
	}
	
	@override
	Widget build(BuildContext context) {
		return Stack(
			children: <Widget>[
				Positioned(
					top: top,
					left: left,
					child: Container(
						height: height,
						width: width,
						color: Colors.red[800].withOpacity(0.4),
						child: widget.child,
					),
				),
				// top left
				Positioned(
					top: top - ballDiameter / 2,
					left: left - ballDiameter / 2,
					child: ManipulatingBall(
						onDrag: (dx, dy) {
							var mid = (dx + dy) / 2;
							var newHeight = height - 2 * mid;
							var newWidth = width - 2 * mid;
							
							setState(() {
								height = newHeight > 0 ? newHeight : 0;
								width = newWidth > 0 ? newWidth : 0;
								top = top + mid;
								left = left + mid;
							});
						},
						handlerWidget: HandlerWidget.VERTICAL,
					),
				),
				// top middle
				Positioned(
					top: top - ballDiameter / 2,
					left: left + width / 2 - ballDiameter / 2,
					child: ManipulatingBall(
						onDrag: (dx, dy) {
							var newHeight = height - dy;
							
							setState(() {
								height = newHeight > 0 ? newHeight : 0;
								top = top + dy;
							});
						},
						handlerWidget: HandlerWidget.HORIZONTAL,
					),
				),
				// top right
				Positioned(
					top: top - ballDiameter / 2,
					left: left + width - ballDiameter / 2,
					child: ManipulatingBall(
						onDrag: (dx, dy) {
							var mid = (dx + (dy * -1)) / 2;
							
							var newHeight = height + 2 * mid;
							var newWidth = width + 2 * mid;
							
							setState(() {
								height = newHeight > 0 ? newHeight : 0;
								width = newWidth > 0 ? newWidth : 0;
								top = top - mid;
								left = left - mid;
							});
						},
						handlerWidget: HandlerWidget.VERTICAL,
					),
				),
				// center right
				Positioned(
					top: top + height / 2 - ballDiameter / 2,
					left: left + width - ballDiameter / 2,
					child: ManipulatingBall(
						onDrag: (dx, dy) {
							var newWidth = width + dx;
							
							setState(() {
								width = newWidth > 0 ? newWidth : 0;
							});
						},
						handlerWidget: HandlerWidget.HORIZONTAL,
					),
				),
				// bottom right
				Positioned(
					top: top + height - ballDiameter / 2,
					left: left + width - ballDiameter / 2,
					child: ManipulatingBall(
						onDrag: (dx, dy) {
							var mid = (dx + dy) / 2;
							
							var newHeight = height + 2 * mid;
							var newWidth = width + 2 * mid;
							
							setState(() {
								height = newHeight > 0 ? newHeight : 0;
								width = newWidth > 0 ? newWidth : 0;
								top = top - mid;
								left = left - mid;
							});
						},
						handlerWidget: HandlerWidget.VERTICAL,
					),
				),
				// bottom center
				Positioned(
					top: top + height - ballDiameter / 2,
					left: left + width / 2 - ballDiameter / 2,
					child: ManipulatingBall(
						onDrag: (dx, dy) {
							var newHeight = height + dy;
							
							setState(() {
								height = newHeight > 0 ? newHeight : 0;
							});
						},
						handlerWidget: HandlerWidget.HORIZONTAL,
					),
				),
				// bottom left
				Positioned(
					top: top + height - ballDiameter / 2,
					left: left - ballDiameter / 2,
					child: ManipulatingBall(
						onDrag: (dx, dy) {
							var mid = ((dx * -1) + dy) / 2;
							
							var newHeight = height + 2 * mid;
							var newWidth = width + 2 * mid;
							
							setState(() {
								height = newHeight > 0 ? newHeight : 0;
								width = newWidth > 0 ? newWidth : 0;
								top = top - mid;
								left = left - mid;
							});
						},
						handlerWidget: HandlerWidget.VERTICAL,
					),
				),
				// center left
				Positioned(
					top: top + height / 2 - ballDiameter / 2,
					left: left - ballDiameter / 2,
					child: ManipulatingBall(
						onDrag: (dx, dy) {
							var newWidth = width - dx;
							
							setState(() {
								width = newWidth > 0 ? newWidth : 0;
								left = left + dx;
							});
						},
						handlerWidget: HandlerWidget.HORIZONTAL,
					),
				),
				// center center
				Positioned(
					top: top + height / 2 - ballDiameter / 2,
					left: left + width / 2 - ballDiameter / 2,
					child: ManipulatingBall(
						onDrag: (dx, dy) {
							//print("$top , $left , $bottom , $right");
							setState(() {
								top = checkHorizontalSideLimit(top + dy, bottom) ? (top + dy) : top;
								left = checkVerticalSideLimit(left + dx, right) ? (left + dx) : left;
							});
							bottom = (top + height).round(); // y2
							right = (left + width).round(); // x2
							widget.finRectangle(returnThis(left, top, right, bottom)); // return the list
						},
						handlerWidget: HandlerWidget.VERTICAL,
					),
				),
			],
		);
	}
}

class ManipulatingBall extends StatefulWidget {
	ManipulatingBall({Key key, this.onDrag, this.handlerWidget});
	
	final Function onDrag;
	final HandlerWidget handlerWidget;
	
	@override
	_ManipulatingBallState createState() => _ManipulatingBallState();
}

enum HandlerWidget { HORIZONTAL, VERTICAL }

class _ManipulatingBallState extends State<ManipulatingBall> {
	double initX;
	double initY;
	
	_handleDrag(details) {
		setState(() {
			initX = details.globalPosition.dx;
			initY = details.globalPosition.dy;
		});
	}
	
	_handleUpdate(details) {
		var dx = details.globalPosition.dx - initX;
		var dy = details.globalPosition.dy - initY;
		initX = details.globalPosition.dx;
		initY = details.globalPosition.dy;
		widget.onDrag(dx, dy);
	}
	
	@override
	Widget build(BuildContext context) {
		return GestureDetector(
			onPanStart: _handleDrag,
			onPanUpdate: _handleUpdate,
			child: Container(
				width: ballDiameter,
				height: ballDiameter,
				decoration: BoxDecoration(
					color: Colors.white70.withOpacity(0.5),
					shape: this.widget.handlerWidget == HandlerWidget.VERTICAL
							? BoxShape.circle
							: BoxShape.rectangle,
				),
			),
		);
	}
}