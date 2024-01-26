import 'package:flutter/material.dart';

class StaffStorageInfo {
  final String? svgSrc, title, totalStorage, numOfFiles;
  final Color? color;
  final int? percentage;
  StaffStorageInfo({
    this.svgSrc,
    this.title,
    this.totalStorage,
    this.numOfFiles,
    this.percentage,
    this.color,
  });
}
