import 'package:flutter/material.dart';

class ToDoHeader extends StatelessWidget {
  const ToDoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 50.0),
        child: Column(
          children: [
            Center(
              child: Text(
                'TODOLIST',
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10.0),
            Center(
              child: Text(
                'Click on the  to mark as complete',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
