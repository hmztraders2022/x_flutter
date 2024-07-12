import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/manage_sapi_controller.dart';

class ResultNotesInfo extends GetView<ManageSapiController> {
  const ResultNotesInfo({
    super.key,
    required this.manageSapiController,
  });

  final ManageSapiController manageSapiController;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        notesTitleInfoDetail(
          content: manageSapiController.changeDateToFormat(manageSapiController.detailListInfo.first.dateCreated.toString()),
          contentIcon: Icons.access_time,
        ),
        const SizedBox(width: 7),
        Text(
          "|",
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w300,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(width: 7),
        notesTitleInfoDetail(
          content: manageSapiController.detailListInfo.first.isExpired == 0 ? 'Expired' : 'New',
          contentIcon: Icons.info_outline,
        ),
        const SizedBox(width: 7),
        Text(
          "|",
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w300,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(width: 7),
        notesTitleInfoDetail(
          content: manageSapiController.detailListInfo.first.author,
          contentIcon: Icons.person,
        ),
      ],
    );
  }
}

Widget notesTitleInfoDetail({required IconData contentIcon, required String content}) {
  return Row(
    children: [
      Icon(
        contentIcon,
        size: 16,
        color: Colors.grey[800]?.withOpacity(.6),
      ),
      const SizedBox(width: 5),
      Text(
        content,
        style: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: Colors.grey[800],
        ),
      ),
    ],
  );
}
