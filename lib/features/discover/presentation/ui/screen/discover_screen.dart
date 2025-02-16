import 'package:flutter/material.dart';
import 'package:movie_app/features/discover/presentation/ui/screen/discover_list_tabs.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Discover Movies And Tv Shows"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Movies"),
            Tab(text: "TV Shows"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          DiscoverList(type: 1), // Movies
          DiscoverList(type: 2), // TV Shows
        ],
      ),
    );
  }
}
