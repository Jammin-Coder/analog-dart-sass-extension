import 'package:sass/src/analog_css/analog_generator.dart';
import 'package:sass/src/analog_css/css_class_manager.dart';
import 'dart:io';

void main(List<String> args) async {
  var files = ['index.html', 'nav.html'];
  
  print('Checking markup for classes every 1 second...');

  File outFile = File('analog.scss');
  outFile.writeAsStringSync('');

  String lastOutput = '';
  while (true) {
    String currentOutput = '';

    var files = ['index.html', 'nav.html'];
    CSSClassManager cssClassManager = CSSClassManager();
    
    List<String> classes = cssClassManager.getClassesFromFiles(files);
    List<String> statements = cssClassManager.getAnalogStatements();

    for (String statement in statements) {
      AnalogGenerator analogGenerator = AnalogGenerator(statement);
      String cssClass = analogGenerator.findMatchingCssClass(classes);

      if (cssClass == '') continue;

      String analogCssClass = analogGenerator.generateAnalogClass(cssClass);
      currentOutput += analogCssClass + '\n';
      
    }
    
    if (lastOutput != currentOutput) {
      lastOutput = currentOutput;
    }

    outFile.writeAsStringSync(lastOutput, mode: FileMode.append);

    await Future.delayed(Duration(seconds: 1));
  }
}