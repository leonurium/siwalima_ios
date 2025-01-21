import 'package:flutter/material.dart';

class UnderMaintenance extends StatefulWidget {
  const UnderMaintenance({super.key});

  @override
  State<UnderMaintenance> createState() => _UnderMaintenanceState();
}

class _UnderMaintenanceState extends State<UnderMaintenance> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300,
        width: 300,
        color: Colors.transparent,
        child: Image.asset(
          'assets/under_maintenance.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
