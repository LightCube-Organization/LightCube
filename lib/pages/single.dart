import 'package:flutter/material.dart';

class Single extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Single Play",
      home: Scaffold(
        appBar: AppBar(
          title: Text('LightCube'),
        ),
        body: GridView.count( // Grid表示
          crossAxisCount: 3, // 横列
          childAspectRatio: 2, // 比率
          crossAxisSpacing: 10.0, // Y Padding
          mainAxisSpacing: 10.0, // X Padding
          children: List.generate(30, (index) {
            return Center(
              child: SizedBox(
                width: double.infinity, //Width full
                height: double.infinity, //Height full
                child: ElevatedButton(
                  child: Text(
                    'Level $index',
                    style: TextStyle(
                      fontSize: 30,
                    )
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[50],
                    onPrimary: Colors.black,
                  ),
                  onPressed: (){},
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}