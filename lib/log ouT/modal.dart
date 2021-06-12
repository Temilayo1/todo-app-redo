import 'package:flutter/material.dart';

import 'log_out.dart';

class ModalBot extends StatelessWidget {
  const ModalBot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool darkTheme = false;
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          // color: Color(
          //   0xff121421,
          // ),
          color: darkTheme ? Colors.white : Color(0xff202124)),
      height: size.height / 9.5,
      child: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          Text(
            'Log Out?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => SingleChildScrollView(
                        child: LogOut(),
                      ),
                    );
                  },
                  child: Container(
                    width: 100,
                    height: size.height / 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.redAccent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Yes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          //  fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 100,
                    height: size.height / 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.yellow),
                      color: Colors.transparent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'No',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          // fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
