import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

import '../models/info_sapi_model.dart';

class ManageSapiController extends GetxController {
  final RxList<InfoSapiModel> listInfo = <InfoSapiModel>[].obs;
  late RxSet<InfoSapiModel> detailListInfo = <InfoSapiModel>{}.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  String changeDateToFormat(String dates) {
    DateTime tanggal = DateTime.parse(dates);
    String tanggalFormatted = intl.DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(tanggal);
    return tanggalFormatted;
  }

  int getDifferentIsInfoExpired(String dates) {
    DateTime tanggal = DateTime.parse(dates).add(const Duration(hours: 35));
    if (DateTime.now().difference(tanggal) < const Duration(hours: 36)) {
      return 1;
    }
    return 0;
  }

  void getListInfo() {
    listInfo.clear();
    var infoList = [
      {
        'idC': 0,
        'dateCreated': '2024-05-07',
        'subtitle': 'Penjualan Sapi Ket 3',
        'isActive': 1,
        'author': 'hamzah',
        'desc':
            'Ini adalah desripsi dari sebuah informasi yang telah dibuat oleh seorang super admin, dan disebarkan ke seluruh akun admin manajemen sapi yang telah di amanati'
      },
      {
        'idC': 1,
        'dateCreated': '2024-05-25',
        'subtitle': 'Pembelian Sapi Jawa',
        'isActive': 1,
        'author': 'hamzah',
        'desc':
            'Ini adalah desripsi dari sebuah informasi yang telah dibuat oleh seorang super admin, dan disebarkan ke seluruh akun admin manajemen sapi yang telah di amanati'
      },
      {
        'idC': 2,
        'dateCreated': '2024-06-11',
        'subtitle': 'Pembelian Sapi PO',
        'isActive': 1,
        'author': 'hamzah',
        'desc':
            'Ini adalah desripsi dari sebuah informasi yang telah dibuat oleh seorang super admin, dan disebarkan ke seluruh akun admin manajemen sapi yang telah di amanati'
      },
      {
        'idC': 3,
        'dateCreated': '2024-06-15',
        'subtitle': 'Kerugian Sapi Mati',
        'isActive': 0,
        'author': 'hamzah',
        'desc':
            'Ini adalah desripsi dari sebuah informasi yang telah dibuat oleh seorang super admin, dan disebarkan ke seluruh akun admin manajemen sapi yang telah di amanati'
      },
      {
        'idC': 4,
        'dateCreated': '2024-07-08',
        'subtitle': 'Pembelian Pakan',
        'isActive': 0,
        'author': 'hamzah',
        'desc':
            'Ini adalah desripsi dari sebuah informasi yang telah dibuat oleh seorang super admin, dan disebarkan ke seluruh akun admin manajemen sapi yang telah di amanati'
      },
    ];

    List<InfoSapiModel> infoListX = infoList.map((item) {
      int isExpirOrNot = getDifferentIsInfoExpired(item['dateCreated'].toString());
      var checked = {
        'idC': item['idC'],
        'dateCreated': item['dateCreated'],
        'subtitle': item['subtitle'],
        'isActive': item['isActive'],
        'isExpired': isExpirOrNot,
        'desc': item['desc'],
        'author': item['author'],
      };
      return InfoSapiModel.fromJson(checked);
    }).toList();
    infoListX.sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
    for (var item in infoListX) {
      listInfo.add(item);
    }
    update();
  }

  void getDetailInfo(int id) {
    detailListInfo.clear();
    for (var item in listInfo) {
      Map<String, dynamic> tempX = item.toJson();
      if (id == tempX['idC']) {
        InfoSapiModel items = InfoSapiModel.fromJson(tempX);
        detailListInfo.add(items);
      }
    }
  }

  void increment() => count.value++;
}
