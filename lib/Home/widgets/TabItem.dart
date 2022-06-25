import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TabItem extends StatefulWidget {
  final Function touched;
  final IconData icon;

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
        
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
              
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.start,
                  children: [


                    Icon(widget.icon,
                    size: 22,
                    color: Colors.black,),
                     const SizedBox(
                      height: 5,
                    ),
                    !widget.active ?  Text(
                      widget.text,
                      style:const TextStyle(fontSize: 10,
                     
                     color: Colors.black),
                    ):            RotatedBox(
                      quarterTurns: 3,
                      child: AnimatedContainer(
                        transform:
                            Matrix4.rotationZ(0.0174444),
                        duration: const Duration(
                            milliseconds: 100),
                        height: 15.0,
                        width: 2.0,
                        decoration: BoxDecoration(
                          color: widget.active
                              ?Colors.black
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
