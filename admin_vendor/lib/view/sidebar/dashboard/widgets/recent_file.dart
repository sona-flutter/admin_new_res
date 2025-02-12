// The main widget
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../model/recent_files.dart';

class RecentFiles extends StatelessWidget {
  const RecentFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0), // Using a standard padding value
      decoration: BoxDecoration(
        color: Theme.of(context)
            .cardColor, // Using theme color instead of hardcoded
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Orders",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columnSpacing: 16.0,
              horizontalMargin: 0,
              columns: const [
                DataColumn(
                  label: Text(
                    "Recent Customer",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Date",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Service",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              rows: List.generate(
                demoRecentFiles.length,
                (index) => _buildDataRow(demoRecentFiles[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildDataRow(RecentFile fileInfo) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (fileInfo.icon != null && fileInfo.icon!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: SvgPicture.asset(
                      fileInfo.icon!,
                      height: 30,
                      width: 30,
                      placeholderBuilder: (context) => const SizedBox(
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                ),
              Flexible(
                child: Text(
                  fileInfo.title ?? 'Unnamed',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DataCell(Text(fileInfo.date ?? '-')),
        DataCell(Text(fileInfo.service ?? '-')),
      ],
    );
  }
}
