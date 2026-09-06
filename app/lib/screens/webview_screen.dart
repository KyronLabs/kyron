import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../widgets/action_sheet.dart';
import '../widgets/toast.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String? title;

  const WebViewScreen({super.key, required this.url, this.title});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  String _currentUrl = '';

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
              _currentUrl = url;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  String _shortenUrl(String url) {
    final uri = Uri.parse(url);
    return uri.host;
  }

  /// The address the reader is actually on, which is not the one they arrived
  /// at once a page has navigated.
  String get _url => _currentUrl.isEmpty ? widget.url : _currentUrl;

  Future<void> _shareUrl() => Share.share(_url);

  /// Hands the page to the real browser.
  Future<void> _openExternally() async {
    final opened = await launchUrl(
      Uri.parse(_url),
      mode: LaunchMode.externalApplication,
    );
    // Says so rather than looking like it worked: this used to be a row that
    // closed the sheet and did nothing at all.
    if (!opened && mounted) {
      Toast.show(context, 'No app on this device can open that link.');
    }
  }

  Future<void> _showBrowserMenu() async {
    final choice = await ActionSheet.show<String>(
      context,
      title: _shortenUrl(_url).toUpperCase(),
      actions: const [
        SheetAction(
          value: 'browser',
          label: 'Open in browser',
          icon: Iconsax.export_3_copy,
        ),
        SheetAction(
          value: 'copy',
          label: 'Copy link',
          icon: Iconsax.copy_copy,
        ),
        SheetAction(
          value: 'refresh',
          label: 'Refresh',
          icon: Iconsax.refresh_copy,
        ),
      ],
    );
    if (choice == null || !mounted) return;

    switch (choice) {
      case 'browser':
        await _openExternally();
      case 'copy':
        await Clipboard.setData(ClipboardData(text: _url));
        if (mounted) Toast.show(context, 'Link copied');
      case 'refresh':
        await _controller.reload();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title ?? 'Web Page',
                style: Theme.of(context).textTheme.bodyLarge),
            if (_currentUrl.isNotEmpty)
              Text(
                _shortenUrl(_currentUrl),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: KyronTheme.darkTextSecondary),
              ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.send_2_copy, size: 20),
            tooltip: 'Share',
            onPressed: _shareUrl,
          ),
          IconButton(
            icon: const Icon(Iconsax.more_copy, size: 20),
            tooltip: 'More',
            onPressed: _showBrowserMenu,
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
