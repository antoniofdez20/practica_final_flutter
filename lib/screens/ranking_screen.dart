import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/controllers/controllers.dart';
import 'package:practica_final_flutter/utils/utils.dart';
import 'package:practica_final_flutter/widgets/widgets.dart';

/// pantalla del ranking de puntuacions dels usuaris
/// pot mostrar els 5 primers usuaris o els usuaris filtrats
class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FirebaseUsersController>();
    final themeController = Get.find<ThemeController>();
    final usersFiltered = controller.filteredUsers;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const TopAppBar(title: 'Ranking'),
        drawer: const MyDrawer(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Obx(
                  () => TextField(
                    onChanged: (value) => controller.updateFilter(value),
                    decoration: CustomInputDecorations.buildInputDecoration(
                        labelText: 'Filtrar ranking',
                        themeController: themeController,
                        suffixIcon: Icon(
                          Icons.search,
                          color: themeController.isDarkMode.value
                              ? MyColors.amber
                              : MyColors.greenVogue,
                        )),
                    style: TextStyle(
                      color: themeController.isDarkMode.value
                          ? MyColors.amber
                          : MyColors.greenVogue,
                    ),
                    cursorColor: themeController.isDarkMode.value
                        ? MyColors.amber
                        : MyColors.greenVogue,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Obx(
                    () => Text(
                      controller.filter.value.isEmpty &&
                              controller.usersNoAdmin.length >= 5
                          ? '🏆 TOP 5 Ranking'
                          : '🏆 Puntuació filtrada',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  )),
              Obx(
                () => Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: themeController.isDarkMode.value
                        ? MyColors.midnightBlue
                        : Colors.white,
                    border: Border.all(
                        color: themeController.isDarkMode.value
                            ? MyColors.amber
                            : MyColors.greenVogue,
                        width: 1.5),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingTextStyle: TextStyle(
                        color: themeController.isDarkMode.value
                            ? MyColors.amber
                            : MyColors.greenVogue,
                        fontWeight: FontWeight.bold,
                      ),
                      columnSpacing: 20,
                      dataRowMinHeight: 40,
                      dataRowMaxHeight: 60,
                      headingRowColor: MaterialStateProperty.all(
                          themeController.isDarkMode.value
                              ? MyColors.midnight
                              : MyColors.easternBlue),
                      columns: const [
                        DataColumn(label: Text('Posició')),
                        DataColumn(label: Text('Nombre d\'usuari')),
                        DataColumn(label: Text('Puntuació')),
                      ],
                      rows: usersFiltered.map<DataRow>((user) {
                        int position =
                            controller.usersNoAdmin.indexOf(user) + 1;
                        int rowPosition = usersFiltered.indexOf(user) + 1;
                        return DataRow(
                          color: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              return (rowPosition % 2 == 0)
                                  ? themeController.isDarkMode.value
                                      ? MyColors.midnight.withOpacity(0.7)
                                      : MyColors.easternBlue.withOpacity(0.5)
                                  : null;
                            },
                          ),
                          cells: [
                            DataCell(Text('$position')),
                            DataCell(Text(user.username)),
                            DataCell(Text(user.xp.toString())),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const CustomNavigationBar(),
      ),
    );
  }
}
