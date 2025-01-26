import 'package:flutter/material.dart';

class CustomScrollViewExample extends StatelessWidget {
  const CustomScrollViewExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: CustomScrollView(
          slivers: <Widget>[
            // 1. SliverAppBar
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('CustomScrollView Example'),
                background: Image.asset(
                  'assets/placeholder.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // 2. SliverToBoxAdapter for a regular widget
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.orange,
                child: const Text(
                  'This is a regular widget inside a SliverToBoxAdapter',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),

            // 3. SliverPersistentHeader
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                minHeight: 50.0,
                maxHeight: 100.0,
                child: Container(
                  color: Colors.lightBlue,
                  child: const Center(
                    child: Text(
                      'Persistent Header',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),

            // 4. SliverList
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ListTile(
                    title: Text('List Item $index'),
                  );
                },
                childCount: 20,
              ),
            ),

            // 5. SliverGrid
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    color: Colors.purple,
                    child: Center(
                      child: Text(
                        'Grid Item $index',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  );
                },
                childCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom SliverPersistentHeaderDelegate
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
