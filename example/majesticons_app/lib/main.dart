import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'icon_map_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Majesticons Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Majesticons Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Map<String, IconData> allIcons = IconMap.getIconMap();
  late List<MapEntry<String, IconData>> filteredIcons;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredIcons = allIcons.entries.toList();
  }

  void updateSearch(String value) {
    setState(() {
      searchQuery = value.toLowerCase();
      filteredIcons = allIcons.entries
          .where((entry) => entry.key.toLowerCase().contains(searchQuery))
          .toList();
    });
  }

  void copyToClipboard(String iconName) {
    final String textToCopy = 'Icon(Majesticons.$iconName)';
    Clipboard.setData(ClipboardData(text: textToCopy));
    _showSnackBar(textToCopy);
  }

  void _showSnackBar(String textToCopy) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied to clipboard: $textToCopy'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildIconGrid(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Search Icons',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
        onChanged: updateSearch,
      ),
    );
  }

  Widget _buildIconGrid() {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = _calculateCrossAxisCount(constraints.maxWidth);
          return GridView.builder(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: filteredIcons.length,
            itemBuilder: (context, index) {
              return _buildIconCard(filteredIcons[index]);
            },
          );
        },
      ),
    );
  }

  int _calculateCrossAxisCount(double maxWidth) {
    const int targetWidth = 150;
    return (maxWidth / targetWidth).floor();
  }

  Widget _buildIconCard(MapEntry<String, IconData> iconEntry) {
    return GestureDetector(
      onTap: () => copyToClipboard(iconEntry.key),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconEntry.value, size: 50.0),
            const SizedBox(height: 10.0),
            Text(
              iconEntry.key,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}
