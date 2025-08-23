import 'package:flutter/material.dart';
import 'package:taskati/core/services/local_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var isDark = LocalHelper.getData(LocalHelper.kIsDark) ?? false;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              LocalHelper.cacheData(LocalHelper.kIsDark, !isDark);
              setState(() {});
            },
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
          ),
        ],
      ),
    );
  }
}
