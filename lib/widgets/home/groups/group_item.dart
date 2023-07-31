import 'package:deadpool/features/friends_group/bloc/friends_group_bloc.dart';
import 'package:deadpool/models/friends_group.dart';
import 'package:deadpool/screens/group_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupItem extends StatelessWidget {
  const GroupItem({super.key, required this.group});

  final FriendsGroup group;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendsGroupBloc, FriendsGroupState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            context.read<FriendsGroupBloc>().add(SelectedFriendsGroup(group: group));
            
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GroupDetails(group: group)),
            );
          },
          child: SizedBox(
            width: double.infinity,
            height: 200,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              clipBehavior: Clip.hardEdge,
              child: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 250,
                    color: Colors.white,
                    child: Image.network(
                      'https://source.unsplash.com/random/?group,friends',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    alignment: Alignment.bottomCenter,
                    decoration:
                        BoxDecoration(color: Colors.black.withAlpha(90)),
                    child: Text(
                      group.name,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
