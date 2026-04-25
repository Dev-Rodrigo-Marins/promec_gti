/// Utility that wraps a builder so a [LoadingScreen] is shown briefly
  /// before the real page is built. It avoids a visual jump when navigating
  /// quickly between routes.
  import 'package:flutter/material.dart';
  import '../loading_screen.dart';

  /// Wraps a builder with a loading screen.
  ///
  /// Usage in a GoRoute:
  ///   builder: (context, state) => withLoading(
  ///     (_) => const HomeClienteScreen(),
  ///   ),
  Widget withLoading(Widget Function(BuildContext) builder) {
    return Builder(
      builder: (BuildContext context) {
        return FutureBuilder<void>(
          future: Future.delayed(const Duration(milliseconds: 700)),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const LoadingScreen();
            }
            return builder(ctx);
          },
        );
      },
    );
  }