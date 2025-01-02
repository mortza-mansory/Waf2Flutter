import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msf/core/component/widgets/custom_iconbutton.dart';
import 'package:msf/core/component/widgets/status_widget.dart';

enum Status {
  defent,
  disabled,
  maintenance,
}

class DataRowTile {
  static DataRow websiteRow({
    required String name,
    required String application,
    required String listenTo,
    required String realWebServer,
    required VoidCallback onTapLog,
    required bool status,
    required Function(Status) onModeChanged,
    required VoidCallback onListenTap,
    required VoidCallback onTapEdit,
    required VoidCallback onTapStart,
    required VoidCallback onTapPause,
    required VoidCallback onTapDelete,
  }) {
    DataCell dataCellMaker(String title) =>
        DataCell(FittedBox(child: Text(title)));
    String capitalize(String input) =>
        "${input[0].toUpperCase()}${input.substring(1)}";

    return DataRow(
      cells: [
        dataCellMaker(name),
        dataCellMaker(application),

        DataCell(FittedBox(
            child: InkWell(onTap: onListenTap, child: Text(listenTo)))),
        dataCellMaker(realWebServer),

        DataCell(
          IconButton(
            icon: Center(
                child: Image.asset(
              "img/search.png",
              width: 25,
              height: 25,
            )),
            onPressed: onTapLog,
            padding: EdgeInsets.zero,
          ),
        ),
        // status
        DataCell(
          StatusWidget(
            title: status ? 'Enabled'.tr : 'Disable'.tr,
            titleColor: Colors.green[900],
          ),
        ),
        DataCell(
          FittedBox(
            child: DropdownButton<Status>(
              value: Status.defent,
              items: Status.values.map((status) {
                return DropdownMenuItem<Status>(
                  value: status,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      capitalize(status.name),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) => onModeChanged(value!),
            ),
          ),
        ),
        DataCell(
          FittedBox(
            child: Row(
              children: [
                CustomIconbuttonWidget(
                  icon: Icons.edit,
                  backColor: Colors.blue,
                  onPressed: onTapEdit,
                ),
                const SizedBox(width: 5),
                CustomIconbuttonWidget(
                  icon: Icons.play_arrow,
                  backColor: Colors.green,
                  onPressed: onTapStart,
                ),
                const SizedBox(width: 5),
                CustomIconbuttonWidget(
                  icon: Icons.pause,
                  backColor: Colors.yellow,
                  iconColor: Colors.black,
                  onPressed: onTapPause,
                ),
                const SizedBox(width: 5),
                CustomIconbuttonWidget(
                  icon: Icons.delete,
                  backColor: Colors.red,
                  onPressed: onTapDelete,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static DataRow addWebsiteRow({
    required String name,
    required String applicationUrl,
    required String status,
    required String author,
    required VoidCallback onTapDeploy,
    required VoidCallback onTapDelete,
  }) {
    DataCell dataCellMaker(String title) => DataCell(
          FittedBox(
            child: Text(title),
          ),
        );
    return DataRow(
      cells: [
        dataCellMaker(name),
        dataCellMaker(applicationUrl),
        DataCell(StatusWidget(
          title: status,
          titleColor: Colors.green[900],
        )),
        DataCell(StatusWidget(
          title: author,
          backgrounColor: Colors.blue[100],
          titleColor: Colors.blueAccent,
        )),
        DataCell(
          FittedBox(
            child: Row(
              children: [
                CustomIconbuttonWidget(
                  icon: Icons.rocket_launch,
                  backColor: Colors.green[300]!,
                  iconColor: Colors.black,
                  titleColor: Colors.black,
                  title: "Deploy1",
                  onPressed: onTapDeploy,
                ),
                const SizedBox(width: 5),
                CustomIconbuttonWidget(
                  icon: Icons.delete_outline_rounded,
                  backColor: Colors.redAccent,
                  title: "Delete",
                  onPressed: onTapDelete,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
