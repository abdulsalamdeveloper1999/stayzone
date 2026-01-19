import 'package:flutter/material.dart';
import '../../main/pages/main_page.dart';

class SelectAppsPage extends StatefulWidget {
  const SelectAppsPage({super.key});

  @override
  State<SelectAppsPage> createState() => _SelectAppsPageState();
}

class _SelectAppsPageState extends State<SelectAppsPage> {
  final Map<String, bool> _suggestedApps = {
    'Instagram': true,
    'TikTok': true,
    'Facebook': false,
    'X': false,
  };

  final Map<String, String> _appSubtitles = {
    'Instagram': 'Social & Media',
    'TikTok': 'Entertainment',
    'Facebook': 'Social Networking',
    'X': 'News & Social',
  };

  final Map<String, IconData> _appIcons = {
    'Instagram': Icons.camera_alt_outlined,
    'TikTok': Icons.music_note_outlined,
    'Facebook': Icons.facebook,
    'X': Icons.close,
  };

  int get _selectedCount => _suggestedApps.values.where((v) => v).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Select Apps'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Choose the apps that distract you the most. We will block access to these during your focus sessions.',
                      style: TextStyle(color: Colors.grey[400], height: 1.5),
                    ),
                    const SizedBox(height: 24),
                    // Search Bar
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search installed apps...',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: const Color(0xFF1D1B26),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Suggested Apps Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Suggested Apps',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _suggestedApps.updateAll((key, value) => true);
                            });
                          },
                          child: const Text(
                            'Select All',
                            style: TextStyle(color: Color(0xFF8B3DFF)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ..._suggestedApps.keys.map((app) {
                      return _buildAppItem(
                        context,
                        app,
                        _appSubtitles[app]!,
                        _appIcons[app]!,
                        _suggestedApps[app]!,
                      );
                    }).toList(),
                    const SizedBox(height: 32),
                    // Other Apps Section
                    const Text(
                      'Other Apps',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildCustomAppButton(context),
                    const SizedBox(height: 32),
                    // Info Banner
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF14111C),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF8B3DFF).withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.info,
                            color: Color(0xFF8B3DFF),
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Selected apps will be completely inaccessible during your scheduled "Focus Mode" sessions. You can update this list anytime.',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 13,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Bottom Action
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const MainPage()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                ),
                child: Text('Confirm Block List ($_selectedCount)'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppItem(
    BuildContext context,
    String name,
    String subtitle,
    IconData icon,
    bool isSelected,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1B26),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF322E40),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[500], fontSize: 13),
                ),
              ],
            ),
          ),
          Switch(
            value: isSelected,
            onChanged: (value) {
              setState(() {
                _suggestedApps[name] = value;
              });
            },
            activeColor: const Color(0xFF8B3DFF),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomAppButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          style: BorderStyle
              .solid, // Flutter doesn't have dash support natively in Border
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF1D1B26),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.add, color: Colors.grey),
          ),
          const SizedBox(width: 16),
          const Text(
            'Add a custom app',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
