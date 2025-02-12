import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const StatsCard({
    Key? key,
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Card(
          color: color,
          child: Container(
            height: 85, // Reduced height
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 8), // Adjusted padding
            child: Column(
              mainAxisSize: MainAxisSize.min, // Use minimum space needed
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, size: 16, color: Colors.white), // Smaller icon
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 1, // Force single line
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12, // Smaller font
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const Spacer(), // Push value to bottom
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28, // Larger number
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
