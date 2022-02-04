extends Node2D

class_name bishop

var square : Vector2
export var white : bool = true
var points : int = 3

onready var sprite = $Sprite
func _ready():
    if !white:
        sprite.texture = preload("res://Resources/black_bishop.png")

func check_legal(target: Vector2):
    if target == Vector2.INF or target == square:
        return false
    var n1 : int = int(abs(target.x - square.x))
    var n2 : int = int(abs(target.y - square.y))
    if n1 != n2 or n1 == 0:
        return false
    var xd : int = int((target.x - square.x) / n1)
    var yd : int = int((target.y - square.y) / n1)

    for i in range(1, n1):
        if get_parent().check_occupied(Vector2(square.x + i * xd, square.y + i * yd), white):
            return false
    return true
