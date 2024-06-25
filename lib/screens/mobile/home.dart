import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nirvafincare/core/utilities/extensions.dart';
import 'package:nirvafincare/pages/mobile/about_us_page.dart';
import 'package:nirvafincare/pages/mobile/home_page.dart';
import 'package:nirvafincare/pages/mobile/products_page.dart';
import 'package:nirvafincare/providers/nav_provider.dart';
import 'package:nirvafincare/providers/scroll_provider.dart';
import 'package:nirvafincare/widgets/mobile/bottom_bar.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MobileHome extends ConsumerStatefulWidget {
  const MobileHome({super.key});

  @override
  ConsumerState<MobileHome> createState() => _MobileHomeState();
}

class _MobileHomeState extends ConsumerState<MobileHome> {
  final List<Widget> pages = <Widget>[
    const MobileHomePage(),
    const MobileProductsPage(),
    const MobileAboutUsPage(),
    const MobileBottomBar(),
  ];

  @override
  void initState() {
    final listener = ref.read(positionListenerProvider);

    listener.itemPositions.addListener(() {
      final item = listener.itemPositions.value;
      final currentIndex = ref.read(navIndexProvider.notifier);
      if (item.last.itemLeadingEdge <= 0.5 &&
          currentIndex.state != item.last.index) {
        currentIndex.state = item.last.index;
      } else if (item.last.itemLeadingEdge > 0.7 &&
          currentIndex.state != item.toList()[item.length - 2].index) {
        currentIndex.state = item.toList()[item.length - 2].index;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(scrollControllerProvider.notifier);
    final listener = ref.read(positionListenerProvider.notifier);

    return SizedBox(
      height: context.height,
      child: ScrollablePositionedList.builder(
        itemScrollController: controller.state,
        itemPositionsListener: listener.state,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        itemCount: pages.length,
        itemBuilder: (_, index) => pages[index],
      ),
    );
  }
}
