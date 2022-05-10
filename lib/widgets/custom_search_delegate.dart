import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo/data/local_storage.dart';
import 'package:todo/main.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/widgets/task_list_item.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<Task> allTasks;

  CustomSearchDelegate({required this.allTasks});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query.isEmpty ? null : query = ' ';
          },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return GestureDetector(
        onTap: () {
          close(context, null);
        },
        child: const Icon(
          Icons.arrow_back_ios,
          color: Colors.amber,
          size: 24,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Task> filteredList = allTasks
        .where(
            (gorev) => gorev.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return filteredList.isNotEmpty
        ? ListView.builder(
            itemBuilder: (context, index) {
              var _oankiListeElemani = filteredList[index];
              return Dismissible(
                  background: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     const Icon(
                        Icons.delete,
                        color: Colors.amber,
                      ),
                     const SizedBox(
                        width: 8,
                      ),
                     const Text('add_task').tr(),
                    ],
                  ),
                  key: Key(_oankiListeElemani.id),
                  onDismissed: (direction) async{
                    filteredList.removeAt(index);
                    await locator<LocalStorage>().deleteTask(task: _oankiListeElemani);
                  },
                  child: TastItem(
                    task: _oankiListeElemani,
                  ));
            },
            itemCount: filteredList.length,
          )
        : Center(
            child:const Text('search_not_found').tr(),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
