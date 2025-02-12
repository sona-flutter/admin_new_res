// First, let's define the RecentFile model
class RecentFile {
  final String? title;
  final String? date;
  final String? service;
  final String? icon;

  RecentFile({
    this.title,
    this.date,
    this.service,
    this.icon,
  });
}

// Demo data
final List<RecentFile> demoRecentFiles = [
  RecentFile(
    title: "Govinda",
    date: "01-03-2021",
    service: "Hair Cut",
    icon: "assets/icons/user.svg",
  ),
  RecentFile(
    title: "Rushikesh",
    date: "27-02-2021",
    service: "-",
    icon: "assets/icons/user.svg",
  ),
  RecentFile(
    title: "Rugved",
    date: "23-02-2021",
    service: "-",
    icon: "assets/icons/user.svg",
  ),
  RecentFile(
    title: "Sound File",
    date: "21-02-2021",
    service: "3.5mb",
    icon: "assets/icons/sound_file.svg",
  ),
  RecentFile(
    title: "Media File",
    date: "23-02-2021",
    service: "2.5gb",
    icon: "assets/icons/media_file.svg",
  ),
  RecentFile(
    title: "Sales PDF",
    date: "25-02-2021",
    service: "3.5mb",
    icon: "assets/icons/pdf_file.svg",
  ),
  RecentFile(
    title: "Excel File",
    date: "25-02-2021",
    service: "34.5mb",
    icon: "assets/icons/excel_file.svg",
  ),
];
