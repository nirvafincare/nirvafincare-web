import 'package:flutter/animation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nirvafincare/core/utilities/extensions.dart';
import 'package:nirvafincare/providers/scroll_provider.dart';

final StateProvider<int> navIndexProvider = StateProvider<int>((_) => 0);

void updatePage(WidgetRef ref, int index) {
  ref.read(navIndexProvider.notifier).update((_) => index);
  ref.read(scrollControllerProvider).scrollTo(
        index: index,
        duration: 800.milliseconds,
        curve: Curves.easeOut,
      );
}
