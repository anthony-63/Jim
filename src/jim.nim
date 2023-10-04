# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.

import class

when isMainModule:
    var reader = jim_class_reader_init("Test.class")
    var java_class = reader.parse_class_file()

    echo java_class

