import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';



circularProgressDrawer(var cgpa, var hours){
    return Container(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularPercentIndicator(
                      radius: 130,
                      lineWidth: 6,
                      percent: hours/132,
                      center: Text("$hours/132 Hours", style: const TextStyle(color: Colors.white),),
                      progressColor: Colors.white,
                    ),
                     const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                    ),
                    CircularPercentIndicator(
                      radius: 130,
                      lineWidth: 6,
                      percent: cgpa/4,
                      center: Text("$cgpa CGPA", style: const TextStyle(color: Colors.white),),
                      progressColor: Colors.white,
                    )]));
  }
