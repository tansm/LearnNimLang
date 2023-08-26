#{.experimental: "codeReordering".}

# 定义一个概念（接口），必须包含只读的 len 属性，以及按索引访问。
type
    IReadonlyList[T] = concept t
        t.len is int
        t.`[]`(int) is T
        for value in t:
            value is T

    VirtualList = object
        len : int

# 基于此概念，进行扩展的方法；
func checkIndex[T](this : IReadonlyList[T], index : int) = 
    if index >= this.len:
        raise newException(IndexDefect, formatErrorIndexBound(0, (this.len - 1)))

func sum[T](this: IReadonlyList[T]) : T =
    for v in this:
        result += v

func `[]`(this: VirtualList, index : int) : int =
    #this.checkIndex(index)
    return index * 2

iterator items(this: VirtualList):int =
    for i in 0 ..< this.len:
        yield this[i]

# 派生的概念
type
    IArray[T] = concept t, var s
        t is IReadonlyList[T]
        t.`[]=`(int,T)
        s.resize(int) is int    #重新定义大小。

proc resize[T](list: var seq[T], newSize : int) : int {.inline.}=
    list.setLen(newSize)

func `[]=`(this: VirtualList, index: int, value : int) =
    this.checkIndex(index)

proc resize(this: var VirtualList, newSize : int) : int =
    this.len = newSize
 
proc update[T](this: var IArray[T], index: int, value : T) =
    if(index >= this.len):
        let _ = this.resize(if index < 4: 4 else: index * 2)
    this[index] = value

proc test() =
    # 演示 鸭子 类型
    var tf = VirtualList(len : 12)
    echo "tf sum:", tf.sum()

    # 展示了鸭子类型的好处
    var t2 = @[1,2,3]
    t2.checkIndex(2)
    echo "t2 sum:", t2.sum()

    # 对 seq 内置类型进行扩展的操作。
    var t3 = @[2,3,4]
    t3.update(4,9)
    assert 9 == t3[4]

    # 自定义类型
    var t4 = VirtualList(len : 2)
    t4.update(5, 99)
    echo "t4 newSize:", t4.len

when isMainModule:
    test()