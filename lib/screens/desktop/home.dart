import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nirvafincare/core/utilities/extensions.dart';
import 'package:nirvafincare/pages/desktop/about_us_page.dart';
import 'package:nirvafincare/pages/desktop/home_page.dart';
import 'package:nirvafincare/pages/desktop/products_page.dart';
import 'package:nirvafincare/providers/nav_provider.dart';
import 'package:nirvafincare/providers/scroll_provider.dart';
import 'package:nirvafincare/widgets/desktop/bottom_bar.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DesktopHome extends ConsumerStatefulWidget {
  const DesktopHome({super.key});

  @override
  ConsumerState<DesktopHome> createState() => _DesktopHomeState();
}

class _DesktopHomeState extends ConsumerState<DesktopHome> {
  final List<Widget> pages = [
    const DesktopHomePage(),
    const DesktopProductsPage(),
    const DesktopAboutUsPage(),
    const DesktopBottomBar(),
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
    return SizedBox(
      height: context.height,
      child: ScrollablePositionedList.builder(
        itemScrollController: ref.read(scrollControllerProvider),
        itemPositionsListener: ref.read(positionListenerProvider),
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        itemCount: pages.length,
        itemBuilder: (_, index) => pages[index],
      ),
    );
  }
}
