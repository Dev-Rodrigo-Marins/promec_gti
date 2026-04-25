import 'dart:async';
import 'package:flutter/material.dart';
import 'loading_screen.dart';

/// Helper to navigate to a new route while showing a loading screen between
/// transitions. The function pushes a translucent [LoadingScreen] and after a
/// short micro‑delay pops it, then pushes the target route. The delay gives the
/// UI enough time to render the loading indicator and avoid a blank screen.
Future<void> navigateWithLoading({
  required BuildContext context,
  required Widget Function(BuildContext) builder,
  RouteSettings? settings,
}) async {
  // Push the loading screen.
  await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => const LoadingScreen(),
      settings: const RouteSettings(name: 'loading'),
    ),
  );
  // Short pause so the loading indicator is visible.
  await Future.microtask(() => null);
  // Pop the loading screen.
  if (Navigator.of(context).canPop()) {
    Navigator.of(context).pop();
  }
  // Push the target page.
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: builder,
      settings: settings,
    ),
  );
}
