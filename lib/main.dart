import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WidgetView(),
    );
  }
}

class WidgetView extends StatefulWidget {
  @override
  State<WidgetView> createState() => _WidgetViewState();
}

class _WidgetViewState extends State<WidgetView> {
  late WebViewController controller;
  double progress = 0;

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          if (await controller.canGoBack()) {
            controller.goBack();
            // Stay in app
            return false;
          } else {
            // Leave app
            return true;
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF009EF7),
            // leading: Image.asset("assets/logo-apk.png"),
            title: Text(
              "OPTIMA POS",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            actions: [
              IconButton(
                onPressed: () => controller.reload(),
                icon: Icon(Icons.refresh),
              ),
            ],
          ),
          body: Column(
            children: [
              LinearProgressIndicator(
                value: progress,
                color: Colors.black,
                backgroundColor: Colors.red,
              ),
              Expanded(
                child: WebView(
                  zoomEnabled: false,
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: 'https://optimapos.my.id/app-login',
                  onWebViewCreated: (controller) {
                    this.controller = controller;
                  },
                  onPageStarted: (url) {
                    print('New website: $url');
                  },
                  onProgress: (progress) =>
                      setState(() => this.progress = progress / 100),
                ),
              ),
            ],
          ),
        ),
      );
}
