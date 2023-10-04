import constant_pool
import fields
import attributes

type JimClassFile* = object
    magic*: string
    major_version*: uint
    minor_version*: uint
    constant_pool_count*: uint
    constant_pool*: seq[JimConstantPoolInfo]
    access_flags*: uint
    this_class*: uint
    super_class*: uint
    interfaces_count*: uint
    interfaces*: seq[uint]
    fields_count*: uint
    fields_seq*: seq[JimFieldInfo]
    attribute_count*: uint
    attirbutes*: seq[JimAttributeInfo]

proc read_class_file*(path: string): JimClassFile =
    var class = JimClassFile()



    return class