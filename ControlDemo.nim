# 定义基础的 Control 类
type
  Control = ref object of RootObj
    x, y, width, height: int

  # 定义抽象方法 draw
method draw(self: Control) {.base.} =
    quit "to override"

# 派生 TextBox 控件
type
  TextBox = ref object of Control
    text: string

  # 实现 TextBox 的 draw 方法
method draw(self: TextBox) =
    echo "Drawing TextBox at (", self.x, ", ", self.y, ") with text: ", self.text

# 派生 Label 控件
type
  Label = ref object of Control
    caption: string

  # 实现 Label 的 draw 方法
method draw(self: Label) =
    echo "Drawing Label at (", self.x, ", ", self.y, ") with caption: ", self.caption

# 容器类用于容纳控件
type
  Container = ref object of Control
    controls: seq[Control]

  # 添加控件到容器
proc addControl(self: Container, control: Control) =
    self.controls.add(control)

  # 绘制容器中的所有控件
method draw(self: Container) =
    for ctrl in self.controls:
      ctrl.draw()

# 创建一些控件实例
var textBox = TextBox(x: 10, y: 20, width: 100, height: 30, text: "Input here")
var label = Label(x: 30, y: 50, width: 120, height: 20, caption: "Hello, Nim!")

# 创建一个容器并添加控件
var container = Container()
container.addControl(textBox)
container.addControl(label)

# 绘制容器中的所有控件
container.draw()
