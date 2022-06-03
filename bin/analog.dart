import 'package:sass/src/analog_css/analog_generator.dart';
import 'package:sass/src/analog_css/css_class_manager.dart';


void main(List<String> args) async {
  var files = ['index.html', 'nav.html'];
  
  print('Checking markup for classes every 1 second...');

  while (true) {
    var files = ['index.html', 'nav.html'];
    CSSClassManager cssClassManager = CSSClassManager();
    
    List<String> classes = cssClassManager.getClassesFromFiles(files);
    List<String> statements = cssClassManager.getAnalogStatements();

    for (String statement in statements) {
      AnalogGenerator analogGenerator = AnalogGenerator(statement);
      analogGenerator.findPatternMatch(classes);
    }
    
    await Future.delayed(Duration(seconds: 1));
  }
}