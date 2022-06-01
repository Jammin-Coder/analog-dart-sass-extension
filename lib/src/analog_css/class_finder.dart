import 'package:sass/src/io.dart';
import 'dart:io';

void appendClassesToFile(String path, List<String> classes) async {
  File file = File(path);
  for (int i = 0; i < classes.length; i++) {
    await file.writeAsString("${classes[i]}\n", mode: FileMode.append);
  }
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


List<String> findClassesFromFile(String filePath) {
  /**
   * Returns list of css classes names from provided file
   */

  var classNames = <String>[];
  var classAttributeRegex = RegExp("class='(.*?)'");

  // All double quotes are replaced with single quotes.
  // This is needed for the regex to work
  var fileContents = readFile(filePath).replaceAll('"', "'");

  var classAttributeMatches = classAttributeRegex.allMatches(fileContents);
  for (RegExpMatch match in classAttributeMatches) {
    var classAttributeString = match[0].toString();

    var classList = getClassNamesFromClassAttribute(classAttributeString);
    for (String className in classList) {
      if (!classNames.contains(className)) {
        classNames.add(className);
      }
    }
  }

  return classNames;

}