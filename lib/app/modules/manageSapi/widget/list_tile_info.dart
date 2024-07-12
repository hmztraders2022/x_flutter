import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/manage_sapi_controller.dart';
import 'notes_info_detail.dart';

Widget listTileInfoSapi(
    {required BuildContext contexts, required String date, required int idCard, required subtitle, required int isActive, required int isExpired}) {
  final ManageSapiController manageSapiController = Get.put(ManageSapiController());

  Future<void> showSheetBTM(BuildContext context, int id) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: GetBuilder(
            init: ManageSapiController(),
            initState: (_) {
              manageSapiController.getDetailInfo(id);
            },
            builder: (_) {
              return Container(
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: 600,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: const Text('Close'),
                            onPressed: () => Get.back(),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      manageSapiController.detailListInfo.first.subtitle,
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 5),
                    ResultNotesInfo(manageSapiController: manageSapiController),
                    const SizedBox(height: 10),
                    Text(
                      manageSapiController.detailListInfo.first.desc,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  return Card(
    color: Colors.white,
    child: ListTile(
      contentPadding: const EdgeInsets.only(right: 15),
      leading: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(4),
        width: 60,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(6),
            bottomRight: Radius.circular(6),
          ),
          color: isExpired == 0 ? Colors.white : Colors.green[700],
        ),
        child: Text(
          isExpired == 0 ? 'Expired' : 'NEW',
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
            color: isExpired == 1 ? Colors.white : Colors.grey[600],
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      title: Text(
        subtitle,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.roboto(
          color: isExpired == 0 ? Colors.red[700] : Colors.green[700],
          fontWeight: FontWeight.w400,
        ),
      ),
      subtitle: Text(
        date,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.roboto(
          color: isExpired == 0 ? Colors.red[700] : Colors.green[700],
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: InkWell(
        onTap: () {
          showSheetBTM(contexts, idCard);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.arrow_circle_right,
              color: isExpired == 0 ? Colors.red[700] : Colors.green[700],
            ),
            Text(
              'Detail',
              style: GoogleFonts.roboto(
                color: isExpired == 0 ? Colors.red[700] : Colors.green[700],
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
