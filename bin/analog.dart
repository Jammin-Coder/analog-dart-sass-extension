import 'package:sass/src/analog_css/css_class_manager.dart';
import 'package:sass/src/io.dart';


void main(List<String> args) async {
  var files = ['index.html', 'nav.html'];
  
  print('Checking markup for classes every 1 second...');

  while (true) {
    var files = ['index.html', 'nav.html'];
    CSSClassManager cssClassManager = CSSClassManager();
    List<String> classes = cssClassManager.getClassesFromFiles(files);
    cssClassManager.appendClassesToFile('css_classes.txt', classes);


    await Future.delayed(Duration(seconds: 1));
  }
}