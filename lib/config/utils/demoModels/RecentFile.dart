class RecentFile {
  final String? icon, title, date, size;

  RecentFile({this.icon, this.title, this.date, this.size});
}

List demoRecentFiles = [
  RecentFile(
    icon: "assets/icons/xd_file.svg",
    title: "Ahmed Ali",
    date: "01-03-2021",
    size: "More Info",
  ),
  RecentFile(
    icon: "assets/icons/Figma_file.svg",
    title: "Shohoruk",
    date: "27-02-2021",
    size: "More Info",
  ),
  RecentFile(
    icon: "assets/icons/doc_file.svg",
    title: "Adib",
    date: "23-02-2021",
    size: "More Info",
  ),
];
