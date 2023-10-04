import attributes

type JimFieldInfo* = object
    access_flags*: uint
    name_index*: uint
    descriptor_index*: uint
    attributes_count*: uint
    attributes*: seq[JimAttributeInfo]