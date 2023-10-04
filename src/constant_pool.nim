type
    JimConstantPoolTagTypes* = enum
        Utf8,
        Integer,
        Float,
        Long,
        Double,
        Class,
        String,
        Fieldref,
        Methodref,
        InterfaceMethodref,
        NameAndType,
        MethodHandle,
        MethodType,
        InvokeDynamic,
    JimConstantPoolInfo* = ref object
        tag*: string
        case kind*: JimConstantPoolTagTypes
        of Class:
            class_name_index*: uint32
        of Fieldref:
            fieldref_class_index*: uint32
            fieldref_name_and_type_index*: uint32
        of Methodref: 
            methodref_class_index*: uint32
            methodref_name_and_type_index*: uint32
        of InterfaceMethodref:
            interfacemethodref_class_index*: uint32
            interfacemethodref_name_and_type_index*: uint32
        of String:
            string_index*: uint32
        of Integer:
            int_bytes*: uint32
        of Float:
            float_bytes*: uint32
        of Long: 
            long_high_bytes*: uint32
            long_low_bytes*: uint32
        of Double:
            double_high_bytes*: uint32
            double_low_bytes*: uint32
        of NameAndType:
            nameandtype_name_index*: uint32
            nameandtype_descriptor_index*: uint32
        of Utf8:
            utf8_length: uint32
            utf8_bytes: seq[byte]
        of MethodHandle:
            methodhandle_reference_kind*: uint32
            methodhandle_reference_index*: uint32
        of MethodType:
            methodtype_descriptor_index*: uint32
        of InvokeDynamic:
            invokedynamic_bootstrap_method_attr_index*: uint32
            invokedynamic_name_and_type_index*: uint32

const JimConstantPoolTags: seq[(uint32, string)] = @[
    (7, "Class"),
    (9, "Fieldref"),
    (10, "Methodref"),
    (11, "InterfaceMethodref"),
    (8, "String"),
    (3, "Integer"),
    (4, "Float"),
    (5, "Long"),
    (6, "Double"),
    (12, "NameAndType"),
    (1, "Utf8"),
    (15, "MethodHandle"),
    (16, "MethodType"),
    (18, "InvokeDynamic")
]

proc find_constant_pool_tag*(index: uint32): string =
    for i in JimConstantPoolTags:
        if i[0] == index:
            return i[1]
    echo "Failed to find constant pool tag with index: ", index
    quit 1