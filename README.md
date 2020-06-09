# Smart Baby Monitoring

This application is developed as a capstone project called Smart Baby Monitoring Device.
It will communicate to a Raspberry Pi device through Firebase. You can find Raspberry Pi source code [over here.](https://github.com/kylethedeveloper/SBMD-RaspberryPi)

## First things first

This project **will not** work if you just clone and run it.
You need to import your **own** *google-services.json* file which is needed to connect to your own Firebase instance. I removed the original one for the sake of *security*.
Detailed information can be found [over here.](https://codelabs.developers.google.com/codelabs/flutter-firebase/#6 "Platform-specific Firebase configuration")

Also, add the following line at the end of the **colors.dart** file by going to its implementation, or change the lines where I used "mySpecialGreen" color. <br/> `static const Color mySpecialGreen = Color(0xFF002800);`

For live streaming of the camera, [Dataplicity](https://dataplicity.com/) service is used to be able to watch the camera over the Internet. It is helpful to get rid of port forwarding shenanigans. [Here is the live streaming guide](https://docs.dataplicity.com/docs/stream-live-video-from-your-pi). Bear in mind that this project uses the [Free Subscription](https://www.dataplicity.com/subscriptions/plans/) among other subscription plans.

## :books: Resources :books:

#### Flutter Related / UI Design
- [ListView - ListTile error solution][listview]
- ["Bottom Overflowed" error][bottomover]
- [Example Switch Usage][switch]
- [Retreive or change the value of a TextField][1]
- [Navigation - Routing between screens][nav]
- [Call function on Back Button pressed][back]
- [Widget over Widget][wow]
- [Resizable Rectangle][resrect]
- [This answer really saved my life][context]
- [NetworkImageWithRetry][netimg]
- [Widget Communication between each other][talkinwidgets]

[listview]: https://stackoverflow.com/questions/50252569/vertical-viewport-was-given-unbounded-height/54587532
[bottomover]: https://medium.com/zipper-studios/the-keyboard-causes-the-bottom-overflowed-error-5da150a1c660
[switch]: https://www.tutorialkart.com/flutter/flutter-switch/
[1]: https://flutter.dev/docs/cookbook/forms/retrieve-input
[nav]: https://flutter.dev/docs/cookbook/navigation
[back]: https://medium.com/@iamatul_k/flutter-handle-back-button-in-a-flutter-application-override-back-arrow-button-in-app-bar-d17e0a3d41f
[wow]: https://stackoverflow.com/questions/51998760/how-can-i-put-a-widget-above-another-widget-in-flutter
[resrect]: https://stackoverflow.com/questions/60924384/creating-resizable-view-that-resizes-when-pinch-or-drag-from-corners-and-sides-i
[context]: https://stackoverflow.com/a/57694034/2031851
[netimg]: https://pub.dev/documentation/flutter_image/latest/
[talkinwidgets]: https://www.digitalocean.com/community/tutorials/flutter-widget-communication


#### Flutter Packages Used
- [flutter_spinkit][f1]
- [cloud_firestore][f2]
- [provider][f3]
- [firebase_auth][f4]
- [email_validator][f5]
- [flutter_mjpeg][f6]

[f1]: https://pub.dev/packages/flutter_spinkit
[f2]: https://pub.dev/packages/cloud_firestore
[f3]: https://pub.dev/packages/provider
[f4]: https://pub.dev/packages/firebase_auth
[f5]: https://pub.dev/packages/email_validator
[f6]: https://pub.dev/packages/flutter_mjpeg

#### Dart Programming Language Related
- [Conditional statements][cond]
- [Optional Function Parameters][2]

[cond]: https://rishabh1403.com/posts/dart/2018/09/dart-programming-language-tutorial-part-7-if-else-and-ternary-operators-in-dart/
[2]: https://zaiste.net/dart-optional-function-parameters/

#### Technical Problems
- [Multidex Solution 1][mul1]
- [Multidex Solution 2][mul2]

[mul1]: https://developer.android.com/studio/build/multidex
[mul2]: https://medium.com/vector-com-mm/how-to-shrinker-may-have-failed-to-optimize-the-java-bytecode-f783cc6174f8