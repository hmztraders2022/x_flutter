import 'package:flutter/material.dart';

import '../../../../../../../widgets/reusable_grid_item.dart';
import '../../../../../../../widgets/title_tabs_custom.dart';

class KalkulasiPengeluaranView extends StatelessWidget {
  const KalkulasiPengeluaranView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            titleTabsCustom(title: 'Macam-macam Pengeluaran'),
            const SizedBox(height: 10),
            reusableGridItem(
              width: MediaQuery.of(context).size.width,
              count: 4,
              countPerRow: 2,
              childBuilder: (buildContext, i) {
                return Padding(
                  padding: const EdgeInsets.all(2),
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text('data'),
                      ],
                    ),
                  ),
                );
              },
              leftRatio: 1,
              rightRatio: 1,
            )
          ],
        ),
      ),
    );
  }
}
