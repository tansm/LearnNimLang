# This is an example how an abstract syntax tree could be modelled in Nim
type
  NodeKind = enum  # the different node types
    nkInt,          # a leaf with an integer value
    nkFloat,        # a leaf with a float value
    nkString,       # a leaf with a string value
    nkAdd,          # an addition
    nkSub,          # a subtraction
    nkIf            # an if statement
  NodeObj = object
    id : int32
    case kind: NodeKind  # the `kind` field is the discriminator
    of nkInt: intVal: int
    of nkFloat: floatVal: float
    of nkString: strVal: string
    of nkAdd, nkSub:
      leftOp, rightOp: Node
    of nkIf:
      condition, thenPart, elsePart: Node

  Node = ref NodeObj

var n = NodeObj(id: 1, kind: nkInt, intVal: 99)
# the following statement raises an `FieldDefect` exception, because
# n.kind's value does not fit:
# n.strVal = ""
echo n.sizeof()

proc test2(node : NodeObj) =
    echo node.id

test2(n)


proc test3(node : Node) =
    echo node.id

# 使用 cast 将 NodeObj 转换为 Node
let newNode : Node = cast[Node](addr(n))
test3(newNode)


proc drawIntNode(self: Node)=
    echo $self.id, " value = ",  self.intVal

proc drawOther(self: Node)=
    echo self.id

proc draw(self: Node)=
    case self.kind:
        of nkInt:
            drawIntNode(self)
        else:
            drawOther(self)

newNode.draw()

