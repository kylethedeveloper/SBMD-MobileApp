# Smart Baby Monitoring

This application is developed as a capstone project called Smart Baby Monitoring Device.
It will communicate to a Raspberry Pi device through Firebase.

### First things first

This project **will not** work if you just clone and run it.
You need to import your **own** *google-services.json* file which is needed to connect to your own Firebase instance. I removed the original one for the sake of *security*.
Detailed information can be found [over here.](https://codelabs.developers.google.com/codelabs/flutter-firebase/#6 "Platform-specific Firebase configuration")

Also, add the following line at the end of the **colors.dart** file by going to its implementation.
`static const Color mySpecialGreen = Color(0xFF002800);`

## :books: Resources :books:

#### UI Design
> [ListView - ListTile error solution][listview]
> ["Bottom Overflowed" error][bottomover]
> [Example Switch Usage][switch]
> [Retreive or change the value of a TextField][1]

[listview]: https://stackoverflow.com/questions/50252569/vertical-viewport-was-given-unbounded-height/54587532
[bottomover]: https://medium.com/zipper-studios/the-keyboard-causes-the-bottom-overflowed-error-5da150a1c660
[switch]: https://www.tutorialkart.com/flutter/flutter-switch/
[1]: https://flutter.dev/docs/cookbook/forms/retrieve-input

#### Flutter Packages
> [flutter_spinkit][f1]
> [cloud_firestore][f2]
> [provider][f3]
> [firebase_auth][f4]
> [email_validator][f5]
> [flutter_vlc_player][f6]

[f1]: https://pub.dev/packages/flutter_spinkit
[f2]: https://pub.dev/packages/cloud_firestore
[f3]: https://pub.dev/packages/provider
[f4]: https://pub.dev/packages/firebase_auth
[f5]: https://pub.dev/packages/email_validator
[f6]: https://pub.dev/packages/flutter_vlc_player

#### Dart Programming Language Related
> [Conditional statements][cond]
> [Optional Function Parameters][2]

[cond]: https://rishabh1403.com/posts/dart/2018/09/dart-programming-language-tutorial-part-7-if-else-and-ternary-operators-in-dart/
[2]: https://zaiste.net/dart-optional-function-parameters/

#### Technical Problems
> [Multidex Solution 1][mul1]
> [Multidex Solution 2][mul2]

[mul1]: https://developer.android.com/studio/build/multidex
[mul2]: https://medium.com/vector-com-mm/how-to-shrinker-may-have-failed-to-optimize-the-java-bytecode-f783cc6174f8