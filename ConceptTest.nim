import math

# 展示在 nim 中，基于 concept （概念）的编程；
type
    # 定义了一个 concept ，很像接口，
    IImmutableIndexList[T] = concept this
        ## 描述了可以使用数字访问列表的功能。
        this.`[]`(SomeInteger) is T

# 现在，我们为符合这个概念的任何对象定义一个功能，例如获取 最大值
func sum1[T](this: IImmutableIndexList[T], low : SomeInteger, high : SomeInteger): T =
    for index in low .. high:
        result = result + this[index]

if isMainModule:
    let list = @[1,2,3,4]
    #let s = sum1(list,1,3)
    let s2 = list.sum()

    #let s2 = sum1(list,1,2)
    echo s2