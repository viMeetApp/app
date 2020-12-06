import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/group/view/group_page.dart';
import 'package:signup_app/home/group_dropdown_widget/cubit/group_dropdown_cubit.dart';
import 'package:signup_app/util/data_models.dart';

class GroupListView extends StatelessWidget {
  final GroupDropdownCubit groupDropdownCubit = GroupDropdownCubit();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupDropdownCubit, Stream<List<Group>>>(
        cubit: groupDropdownCubit,
        builder: (context, state) {
          return StreamBuilder(
              stream: state,
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Container(
                    height: 0,
                  );
                else {
                  return ListView.builder(
                      //ToDO Maybe only make scrollable if needed
                      //Only Scrollable when more than 5 Elements -> Das ist nicht schön vielleicht gibt es einen weg erst wenn nicht mehr alles gebaut werden kann Scrollbar zu machen
                      /*physics: snapshot.data.length < 10
                          ? NeverScrollableScrollPhysics()
                          : null,*/
                      //shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return ListElement(
                          group: snapshot.data[index],
                        );
                      });
                }
              });
        });
  }
}

class ListElement extends StatelessWidget {
  final Group group;
  ListElement({@required this.group});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, GroupPage.route(group: group));
      },
      child: Padding(
        padding:
            const EdgeInsets.only(top: 8.0, bottom: 8, left: 12, right: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.green),
              height: 30,
              width: 30,
            ),
            SizedBox(
              width: 30,
            ),
            Flexible(
              child: Text(group.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}
