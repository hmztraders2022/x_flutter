import 'package:beta_x/widgets/title_custom_appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../../../../widgets/text_style_custom.dart';
import '../controller/beranda_keuangan_controller.dart';

class TambahBaruPengeluaranView extends GetView<BerandaKeuanganController> {
  TambahBaruPengeluaranView({super.key});

  final BerandaKeuanganController berandaKeuanganController = Get.put(BerandaKeuanganController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController tanggalController = TextEditingController(text: DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.now()).toString());
  TextEditingController titleController = TextEditingController();
  TextEditingController jumlahPengeluaran = TextEditingController();
  TextEditingController authorController = TextEditingController(text: 'Hamzah');
  TextEditingController keterangan = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //here
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: titleCustomAppbar(title: 'Pengeluaran Baru'),
          backgroundColor: Colors.blueGrey[900],
          foregroundColor: Colors.white,
        ),
        backgroundColor: Colors.grey[50],
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textFieldCustom(
                        controller: authorController,
                        label: 'Author (Read-only)',
                        keyboardType: TextInputType.number,
                        icon: Icons.person,
                        readOnly: true,
                        isTextarea: false,
                        inputFormatters: [],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tanggal tidak boleh kosong!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      textFieldCustom(
                        controller: tanggalController,
                        label: 'Tanggal (Read-only)',
                        keyboardType: TextInputType.number,
                        icon: Icons.calendar_today,
                        readOnly: true,
                        isTextarea: false,
                        inputFormatters: [],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tanggal tidak boleh kosong!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      textFieldCustom(
                        controller: titleController,
                        label: 'Nama Pengeluaran',
                        keyboardType: TextInputType.text,
                        icon: Icons.abc,
                        readOnly: false,
                        isTextarea: false,
                        inputFormatters: [],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama pengeluaran tidak boleh kosong!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      textFieldCustom(
                        controller: jumlahPengeluaran,
                        label: 'Jumlah Pengeluaran',
                        keyboardType: TextInputType.number,
                        icon: Icons.numbers,
                        readOnly: false,
                        isTextarea: false,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Jumlah pengeluaran tidak boleh kosong!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      textFieldCustom(
                        controller: keterangan,
                        label: 'Keterangan',
                        keyboardType: TextInputType.multiline,
                        icon: Icons.text_format,
                        readOnly: false,
                        isTextarea: true,
                        inputFormatters: [],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Keterangan tidak boleh kosong!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Get.snackbar('Sukses', 'Menambahkan data baru pengeluaran', backgroundColor: Colors.green);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please fill input')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          backgroundColor: Colors.blueAccent,
                        ),
                        child: textCustomStyle(
                          textColor: Colors.white,
                          fontSize: 14,
                          text: 'Tambah',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget textFieldCustom({
  required TextEditingController controller,
  required String label,
  required IconData icon,
  required String? Function(String?)? validator,
  required TextInputType keyboardType,
  required List<TextInputFormatter> inputFormatters,
  required bool readOnly,
  required bool isTextarea,
}) {
  return TextFormField(
    readOnly: readOnly,
    controller: controller,
    keyboardType: keyboardType,
    inputFormatters: inputFormatters,
    style: GoogleFonts.roboto(
      fontSize: 14,
      color: Colors.black87,
    ),
    textAlignVertical: TextAlignVertical.top,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black45, fontSize: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: Colors.red),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black45, width: 0.0),
      ),
      suffixIcon: Icon(
        icon,
        color: Colors.black45,
      ),
      filled: true,
      fillColor: Colors.white,
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black38),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
    ),
    validator: validator,
    minLines: isTextarea ? 6 : null,
    maxLines: isTextarea ? null : 1,
  );
}
