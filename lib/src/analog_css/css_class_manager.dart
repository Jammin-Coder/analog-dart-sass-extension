import 'package:sass/src/io.dart';
import 'dart:io';

class CSSClassManager {
  List<String> cssClasses = [];

  List<String> getAnalogStatements() {
    File file = File('analog_statements.txt');
    return file.readAsLinesSync();
  }

  List<String> getClassNamesFromClassAttribute(String classAttribute) {
    var parsedClassNames = <String>[];

    // Remove quotes
    classAttribute = classAttribute.replaceAll("'", '').replaceAll('"', '');
    
    // Remove 'class=' from attribute
    var classString = classAttribute.replaceFirst('class=', '');

    // Add individual class names to parsedClassNames list
    var unparsedClassNames = classString.split(' ');
    for (String className in unparsedClassNames) {
      className = className.trim();
      if (!parsedClassNames.contains(className)) {
        parsedClassNames.add(className);
      }
    }

    return parsedClassNames;
  }


  List<String> getClassesFromFile(String filePath) {
    /**
     * Returns list of css classes names from provided file
     */

    var classAttributeRegex = RegExp("class='(.*?)'");

    // All double quotes are replaced with single quotes.
    // This is needed for the regex to work
    String fileContents = readFile(filePath).replaceAll('"', "'");
    List<String> classes = [];

    var classAttributeMatches = classAttributeRegex.allMatches(fileContents);
    for (RegExpMatch match in classAttributeMatches) {
      var classAttributeString = match[0].toString();

      var classList = getClassNamesFromClassAttribute(classAttributeString);
      for (String className in classList) {
        if (!classes.contains(className)) classes.add(className);
      }
    }

    return classes;
  }

  List<String> getClassesFromFiles(List<String> files) {
    for (String file in files) {
      List<String> classes = getClassesFromFile(file);
      for (String cssClass in classes) {
        if (!cssClasses.contains(cssClass)) cssClasses.add(cssClass);
      }
    }

    return cssClasses;
  }
}

