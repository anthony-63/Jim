import constant_pool
import fields
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

type JimClassReader* = object
    stream: FileStream

proc jim_class_reader_init*(filename: string): JimClassReader =
    var reader = JimClassReader()

    reader.stream = newFileStream(filename, mode = fmRead)
    
    return reader

proc read_u1*(reader: var JimClassReader): uint32 =
    var bytes: array[1, byte]
    discard reader.stream.readData(bytes.addr, 1)
    return cast[uint32](bytes)

proc read_u2*(reader: var JimClassReader): uint32 =
    var bytes: array[2, byte]
    discard reader.stream.readData(bytes.addr, 2)
    return cast[uint32]([bytes[1], bytes[0]])

proc read_u4*(reader: var JimClassReader): uint32 =
    var bytes: array[4, byte]
    discard reader.stream.readData(bytes.addr, 4)
    return cast[uint32]([bytes[3], bytes[2], bytes[1], bytes[0]])

proc get_constant_pool*(reader: var JimClassReader, count: uint32): seq[JimConstantPoolInfo] =
    var constant_pool: seq[JimConstantPoolInfo]

    for i in 0..(count-1):
        var tag = find_constant_pool_tag(reader.read_u1())

        case tag:
        of "Utf8": assert(false, "Tag not implemented \"Utf8\"")

        of "Integer": assert(false, "Tag not implemented \"Integer\"")

        of "Float": assert(false, "Tag not implemented \"Float\"")

        of "Long": assert(false, "Tag not implemented \"Long\"")

        of "Double": assert(false, "Tag not implemented \"Double\"")

        of "Class": 
            var constant = JimConstantPoolInfo(kind: Class)
            constant.class_name_index = reader.read_u2()
            constant_pool.add(constant)

        of "String": assert(false, "Tag not implemented \"String\"")

        of "Fieldref": assert(false, "Tag not implemented \"Fieldref\"")

        of "Methodref": 
            var constant = JimConstantPoolInfo(kind: Methodref)
            constant.methodref_class_index = reader.read_u2()
            constant.methodref_name_and_type_index = reader.read_u2()
            constant_pool.add(constant)

        of "InterfaceMethodref": assert(false, "Tag not implemented \"InterfaceMethodref\"")

        of "NameAndType": assert(false, "Tag not implemented \"NameAndType\"")

        of "MethodHandle": assert(false, "Tag not implemented \"MethodHandle\"")

        of "MethodType": assert(false, "Tag not implemented \"MethodType\"")
        
        of "InvokeDynamic": assert(false, "Tag not implemented \"InvokeDynamic\"")

        echo repr(constant_pool[i])

    return constant_pool

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