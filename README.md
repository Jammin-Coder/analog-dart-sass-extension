


# Analog Sass (work in progress)
### Forked and modified from https://github.com/sass/dart-sass.


## What is it?
A modified version of Sass that allows to create dynamic template classes whos 
property values are determined by positional arguments in class names provided in the user's markup.  

## Example
Let's define a template class to apply dynamic amounts of padding to an element:
```SCSS
._padding-#PADDING {
  padding: #PADDINGrem;
}
```

The anlog compiler views this template as: 
```CSS
.padding-{parameter_value} {
  padding: {parameter_value}rem;
}
```

So when a user has a class name in their HTML like `padding-1`, AnalogCSS will generate this class:  
```CSS
.padding-1 {
  padding: 1rem;
}
```

If the class name in the markup were `padding-2`, it would generate this:  
```CSS
.padding-2 {
  padding: 2rem;
}
```

The parameters are denoted by a hash symbol (`#`), and must be separated by dashes (`-`) when used in the class name as a parameter.  

### This was just a brief overview of the main concepts of the program; there are still many bugs and many improvements that need to be made. I will update the docs as I add/change features 
