import 'package:sass/src/io.dart';
import 'dart:io';

import './class_finder.dart';

class AnalogGenerator {
  String statement = '';
  String className = '';
  List<String> classNameComponents = [];

  AnalogGenerator(this.statement) {
    className = getClassName();
    classNameComponents = className.split('-');
  }

  String getClassName() {
    return statement.split(' ')[0];
  }

  List<String>? getExpectedParams() {
    var expectedParams = <String>[];

    for (String component in classNameComponents) {
      if (component[0] == '#') {
        if (expectedParams.contains(component)) {
          print('Duplicate parameters in ' + className);
          return null;
        }

        expectedParams.add(component);
      }
    }

    return expectedParams;
  }
}