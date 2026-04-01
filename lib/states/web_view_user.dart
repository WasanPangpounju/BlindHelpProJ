import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewUser extends StatefulWidget {
  const WebViewUser({super.key});

  @override
  State<WebViewUser> createState() => _WebViewUserState();
}

class _WebViewUserState extends State<WebViewUser> {
  WebViewController? webViewController;

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (progress) {},
        onPageStarted: (url) {},
        onPageFinished: (url) {},
        onWebResourceError: (error) {},
        onNavigationRequest: (request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(Uri.parse('https://innoredis.com/forums/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: WebViewWidget(controller: webViewController!)),
    );
  }
}
