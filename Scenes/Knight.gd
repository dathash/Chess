extends Node2D

var square : Vector2
export var white : bool = true
var points : int = 3

onready var sprite = $Sprite
func _ready():
    if !white:
        sprite.texture = preload("res://Resources/black_knight.png")

func check_legal(target: Vector2):
    if target == Vector2.INF or target == square:
        return false
    elif get_parent().check_occupied(target, white):
        return false
    var movement : Vector2 = target - square
    if movement.abs() == Vector2(2, 1) or movement.abs() == Vector2(1, 2):
        return true
    return false
