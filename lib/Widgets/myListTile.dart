
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class myListTile extends StatefulWidget {
  myListTile({
    required this.leading,
    required this.title,
    required this.trailing,
    required this.onTap
  });

  Widget trailing;
  Icon leading;
  String title;
  Function onTap;

  @override
  State<myListTile> createState() => _myListTileState();
}

class _myListTileState extends State<myListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.leading,
      title: Text(widget.title),
      trailing: widget.trailing,
      onTap: widget.onTap(),
    );
  }
}