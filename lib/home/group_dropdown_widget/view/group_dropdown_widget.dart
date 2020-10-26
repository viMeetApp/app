import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/home/cubit/home_page_cubit.dart';
import 'package:signup_app/home/group_dropdown_widget/cubit/group_dropdown_cubit.dart';
import 'package:signup_app/util/data_models.dart';

class GroupDropownWidget extends StatelessWidget {
  final GroupDropdownCubit groupDropdownCubit = GroupDropdownCubit();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        constraints:
            BoxConstraints(maxHeight: 0.6 * MediaQuery.of(context).size.height),
        decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            boxShadow: [
              new BoxShadow(
                color: Colors.grey[400],
                blurRadius: 20.0,
              ),
            ]),

        // margin: const EdgeInsets.all(8),
        //constraints: BoxConstraints.lerp(a, b, t),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Musste Stack verwenden weil ich sonst nicht links un mitte als Positionierung hinbekomme habe
              //!Fix Alingment inside Stack
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          BlocProvider.of<HomePageCubit>(context).closeGroups();
                        }),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Text("Meine Gruppen",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                ],
              ),

              BlocBuilder<GroupDropdownCubit, Stream<List<Group>>>(
                  cubit: groupDropdownCubit,
                  builder: (context, state) {
                    return StreamBuilder(
                        stream: state,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return Container(height: 0,);
                          else {
                            return ListView.builder(
                              //Only Scrollable when more than 5 Elements -> Das ist nicht schön vielleicht gibt es einen weg erst wenn nicht mehr alles gebaut werden kann Scrollbar zu machen
                                physics: snapshot.data.length < 10
                                    ? NeverScrollableScrollPhysics()
                                    : null,
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return ListElement(
                                    group: snapshot.data[index],
                                  );
                                });
                          }
                        });
                  }),
              //Solange Anzahl unter mindestAnzahl nicht scrollable danach scrollable machen

              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: GestureDetector(
                    onTap: () {
                      print("Gruppe hinzufügen tapped");
                    },
                    child: Text(
                      "+  Gruppe hinzufügen",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ListElement extends StatelessWidget {
  final Group group;
  ListElement({@required this.group});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Element in List Tapped");
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
            Text(group.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
