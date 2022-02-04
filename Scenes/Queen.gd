extends Node2D

class_name queen

var square : Vector2
export var white : bool = true
var points : int = 8

onready var sprite = $Sprite
func _ready():
    if !white:
        sprite.texture = preload("res://Resources/black_queen.png")

func check_legal(target: Vector2):
    # Rook portion.
    if target == Vector2.INF or target == square:
        return false
    if target.x == square.x or target.y == square.y:
        var direction : Vector2 = (target - square).normalized()
        for i in range(1, (target - square).length() + 1):
            if get_parent().check_occupied(square + direction * i, white):
                return false
        return true
    # Bishop Portion.
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
