import 'package:flutter/cupertino.dart';
import '../../data/model/user_dao.dart';
import 'item_user.dart';

typedef OnItemClick = Function(int position);

class UserListViewWidget extends StatefulWidget {
  final List<UserDao> userList;
  final OnItemClick onItemClick;
  const UserListViewWidget({
    super.key,
    required this.userList,
    required this.onItemClick
  });

  @override
  State<UserListViewWidget> createState() => _UserListViewWidgetState();
}

class _UserListViewWidgetState extends State<UserListViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: widget.userList.length,
          itemBuilder: (context,position){
            return ItemUser(
                user: widget.userList[position],
                onItemClick: widget.onItemClick,
                position: position
            );
          }
      ),
    );
  }
}
