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

  List<int> getPrameterPositions(String analogStatementClass) {
    List<int> positions = [];
    List<String> components = analogStatementClass.split('-');

    for (int i = 0; i < components.length; i++) {
      String component = components[i];
      if (component[0] == '#') positions.add(i);
    }

    return positions;
  }

  int getParamCount(String analogStatementClass) {
    return getPrameterPositions(analogStatementClass).length;
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

  Map<String, String> getMappedParams(String cssClass) {
    Map<String, String> paramMap = {};
    List<String> cssClassComponents = cssClass.split('-');
    for (int pos in parameterPostitions) {
      String param = classNameComponents[pos];
      paramMap[param] = cssClassComponents[pos];
    }
    
    return paramMap;
  }

  bool componentIsParam(String component) {
    return component[0] == '#';
  }

  bool statementMatchesAnalogClass(String cssClassName, String analogClassName) {
    List<String> cssClassComponents = cssClassName.split('-');
    List<String> analogClassComponents = analogClassName.split('-');

    // Incorrect length
    if (cssClassComponents.length != analogClassComponents.length) return false;

    int i = 0;
    for (String component in cssClassComponents) {
      String analogComponent = analogClassComponents[i];

      if (component != analogComponent && !componentIsParam(analogComponent)) return false;
      i++;
    }
    
    return true;
  }

  String findMatchingCssClass(List<String> classNamesToCompare) {
    for (String cssClass in classNamesToCompare) {
      if (!statementMatchesAnalogClass(cssClass, className)) continue;
      return cssClass;
    }

    return '';
  }

  String generateAnalogClass(String cssClass) {
    String output = statement;
    
    Map<String, String> paramMap = getMappedParams(cssClass);
    
    for (String paramName in paramMap.keys) {
      String paramValue = paramMap[paramName]!;

      RegExp pattern = RegExp(r'' + paramName);

      output = output.replaceAll(pattern, paramValue);
    }

    return output.replaceFirst('._', '.');

  }
}