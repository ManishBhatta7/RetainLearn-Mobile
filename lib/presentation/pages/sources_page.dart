import 'package:flutter/material.dart';
import '../../core/theme/retain_learn_theme.dart';

class SourcesPage extends StatelessWidget {
  const SourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RetainLearnTheme.paperOffWhite,
      appBar: AppBar(
        title: const Text("My Learning Sources"),
        backgroundColor: RetainLearnTheme.paperWhite,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.folder_open_outlined, size: 64, color: RetainLearnTheme.textLight),
            const SizedBox(height: 16),
            Text(
              "No Sources Yet",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.upload_file),
              label: const Text("Upload Source"),
            ),
          ],
        ),
      ),
    );
  }
}
