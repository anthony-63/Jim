# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.

import class
import reader

when isMainModule:
    var class_reader = jim_class_reader_init("test/Test.class")
    var java_class = class_reader.parse_class_file()

    echo java_class

