import std/streams

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