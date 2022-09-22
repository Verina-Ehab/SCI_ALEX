import 'package:flutter/material.dart';
import 'package:sci_alex/reusable_components/colors.dart';

Container circularProgress() {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(top: 10.0),
    child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(darkBlue)),
  );
}

Container linearProgress() {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(bottom: 10.0),
    child: const LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation(darkBlue)),
  );
}
