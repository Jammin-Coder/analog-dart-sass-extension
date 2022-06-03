import 'package:sass/src/io.dart';
import 'dart:io';
import 'css_class_manager.dart';
import 'dart:core';

class AnalogGenerator {
  String statement = '';
  String className = '';
  List<int> parameterPostitions = [];

  List<String> classNameComponents = [];
  int componentCount = 0;
  int parameterCount = 0;

  AnalogGenerator(this.statement) {
    className = getClassName();

    classNameComponents = className.split('-');
    parameterPostitions = getPrameterPositions(className);

    componentCount = classNameComponents.length;
    parameterCount = parameterPostitions.length;
  }

  String getClassName() {
    return statement.split(' ')[0].replaceFirst('._', '');
  }

  List<int> getPrameterPositions(String analogClass) {
    List<int> positions = [];
    List<String> components = analogClass.split('-');

    for (int i = 0; i < components.length; i++) {
      String component = components[i];
      if (component[0] == '#') positions.add(i);
    }

    return positions;
  }

  int getParamCount(String analogClass) {
    return getPrameterPositions(analogClass).length;
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


  bool parameterPositionsOK(List<int> paramPositions) {
    int i = 0;
    for (int pos in paramPositions) {
      if (pos != parameterPostitions[i]) return false;
      i++;
    }

    return true;
  }

  String findPatternMatch(List<String> classNamesToCompare) {
    String output = "";

    for (String analogClass in classNamesToCompare) {
      List<String> componentsToCompare = analogClass.split('-');

      // Skip itteration if any of these conditions are met
      if (componentsToCompare.length != componentCount) continue;
      print('Class $analogClass matches $className');


    }    
    return output;
  }
}