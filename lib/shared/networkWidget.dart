import 'dart:async';
import 'package:Classmate/services/services.dart';
import 'package:Classmate/shared/shared.dart';
import 'package:flutter/material.dart';

class Network extends StatefulWidget {
  Network({@required this.child});

  Widget child;
  @override
  NetworkState createState() => new NetworkState();
}

class NetworkState extends State<Network> {
  StreamSubscription _connectionChangeStream;

  bool isOffline = false;

  @override
  initState() {
    super.initState();

    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;
    });
  }

  @override
  Widget build(BuildContext ctxt) {
    return (isOffline) ? FadeIn(
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
          Container(height: 80,)
        ],
      ),
    ) : widget.child;
  }
}

/*import 'package:Classmate/enums/connectivity_status.dart';
import 'package:Classmate/shared/shared.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Network extends StatelessWidget {
  final Widget child;

  Network({
    this.child,
  });



  @override
  Widget build(BuildContext context) {
    // Get our connection status from the provider
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    if (connectionStatus == ConnectivityStatus.WiFi) {
      return child;
    }
    if (connectionStatus == ConnectivityStatus.Cellular) {
      return child;
    }
    return FadeIn(
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
          Container(height: 80,)
        ],
      ),
    );
  }
}
*/
