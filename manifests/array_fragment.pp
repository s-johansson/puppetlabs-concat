# @summary
#   Defines an array element, which can be collected later independently of any scope.
#
# @param array
#   The target array name 
#
# @param value
#   The value of the array element.
#
define concat::array_fragment(
  String[1]                          $array,
  String[1]                          $value

) {

  notify{"DEBUG: Defining array_fragment ${name} for target array ${array} with value ${value}":
    loglevel => debug
  }

  array_fragment{ $name:
    array => $array,
    value => value
  }
}
