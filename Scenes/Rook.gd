extends Node2D

class_name rook

var square : Vector2
export var white : bool = true
var castling : bool = true
var points : int = 5

onready var sprite = $Sprite
func _ready():
    if !white:
        sprite.texture = preload("res://Resources/black_rook.png")

func check_legal(target: Vector2):
    if target == Vector2.INF or target == square:
        return false
    if target.x != square.x and target.y != square.y:
        return false
    var direction : Vector2 = (target - square).normalized()
    for i in range(1, (target - square).length() + 1):
        if get_parent().check_occupied(square + direction * i, white):
            return false
    castling = false
    return true
