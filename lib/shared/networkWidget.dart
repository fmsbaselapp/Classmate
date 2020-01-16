import 'dart:async';
import 'package:Classmate/services/services.dart';
import 'package:Classmate/shared/shared.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class Network extends StatefulWidget {
  Network({@required this.child});

  Widget child;
  @override
  NetworkState createState() => new NetworkState();
}

class NetworkState extends State<Network> {
  StreamSubscription _subscription;

  bool isOffline;

  @override
  initState() {

    
    super.initState();
var connectivityResult = await (Connectivity().checkConnectivity());
if (connectivityResult == ConnectivityResult.mobile) {
  // I am connected to a mobile network.
} else if (connectivityResult == ConnectivityResult.wifi) {
  // I am connected to a wifi network.
}
    _subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        // Got a new connectivity status!
      },
    );
  }

//TODOO obedraa :)

  @override
  Widget build(BuildContext ctxt) {
    return (isOffline)
        ? FadeIn(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.signal_wifi_off,
                  size: 60,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: Text(
                    'Scheint so, als hättest du kein Internet.',
                    style: Theme.of(context).textTheme.headline,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  height: 80,
                )
              ],
            ),
          )
        : widget.child;
  }

  await(Future<ConnectivityResult> checkConnectivity) {}
}
