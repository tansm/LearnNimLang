func get1Byte(s: openArray[uint8], index: int): uint32 =
    s[index].uint32

func get2ByteL(s: openArray[uint16], index : int):uint32 = 
    # (cast[ptr uint32](addr s[index * 2]))[]
    s[index].uint32

type
    DKV1 = object
        size : byte
        items : UncheckedArray[uint8] #array[0,uint8]

var data = @[4'u8, 1, 126, 127, 200]
assert 4 == data.get1Byte(0)
assert 1 == data.get1Byte(1)
assert 126 == data.get1Byte(2)
assert 127 == data.get1Byte(3)
assert 200 == data.get1Byte(4)

var data2 = @[0'u16, 1, 1024, 65535, -1]
assert 0 == data2.get2ByteL(0)
assert 1 == data2.get2ByteL(1)
assert 1024 == data2.get2ByteL(2)
assert 65535 == data2.get2ByteL(3)
assert 65535 == data2.get2ByteL(4)

var dataPtr = addr data[1]
var myItems = cast[ptr UncheckedArray[uint8]](dataPtr)
assert 127'u8 == myItems[2]

var dkPtr = addr data[0]
var dk :ptr DKV1 = cast[ptr DKV1](dkPtr)
assert 4'u8 == dk.size
assert 200'u8 == dk.items[3]