import constant_pool
import fields
import reader
import attributes

import std/streams
import std/strutils

type JimClassFile* = object
    magic*: string
    major_version*: uint32
    minor_version*: uint32
    constant_pool_count*: uint32
    constant_pool*: seq[JimConstantPoolInfo]
    access_flags*: uint32
    this_class*: uint32
    super_class*: uint32
    interfaces_count*: uint32
    interfaces*: seq[uint32]
    fields_count*: uint32
    fields_seq*: seq[JimFieldInfo]
    attribute_count*: uint32
    attirbutes*: seq[JimAttributeInfo]

proc parse_class_file*(reader: var JimClassReader): JimClassFile =
    var class = JimClassFile()

    class.magic = toHex(reader.read_u4())

    if class.magic != "CAFEBABE":
        echo "Invalid file magic: ", class.magic
        quit 1
    
    class.minor_version = reader.read_u2()
    class.major_version = reader.read_u2()

    class.constant_pool_count = reader.read_u2()

    class.constant_pool = reader.get_constant_pool(class.constant_pool_count)

    return class