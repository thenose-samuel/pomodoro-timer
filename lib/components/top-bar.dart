import 'package:flutter/material.dart';

import '../colors.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      //crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 340,
          height: 45,
          decoration: const BoxDecoration(
              //color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(50)),
              border: Border(
                  bottom: BorderSide(color: AppColors.taskBarBorder, width: 2),
                  top: BorderSide(color: AppColors.taskBarBorder, width: 2),
                  left: BorderSide(color: AppColors.taskBarBorder, width: 2),
                  right: BorderSide(color: AppColors.taskBarBorder, width: 2))),
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              //textBaseline: TextBaseline.alphabetic,
              children: [
                const Text(
                  'Task_name',
                  style: TextStyle(color: AppColors.taskBarText, fontSize: 18),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_downward_rounded,
                    size: 19,
                  ),
                  onPressed: () => {},
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
