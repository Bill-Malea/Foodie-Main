import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TabItem extends StatefulWidget {
  final Function touched;
  final String icon;

  final bool active;
  final String text;
  const TabItem({
    Key? key,
    required this.touched,
    required this.active,
    required this.text,
    required this.icon,
  }) : super(key: key);
  @override
  _TabItemState createState() => _TabItemState();
}

class _TabItemState extends State<TabItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          widget.touched();
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                height: 120,
                width: 50,
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      widget.icon,
                      height: 80,
                      width: 50,
                    ),
                    Text(
                      widget.text,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RotatedBox(
                      quarterTurns: 3,
                      child: AnimatedContainer(
                        transform:
                            Matrix4.rotationZ(0.0174444),
                        duration: const Duration(
                            milliseconds: 100),
                        height: 10.0,
                        width: 2.0,
                        decoration: BoxDecoration(
                          color: widget.active
                              ? Theme.of(context)
                                  .primaryColor
                              : Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
