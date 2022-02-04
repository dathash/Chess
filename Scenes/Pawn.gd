extends Node2D

func get_class(): return "Pawn"

var square : Vector2
export var white : bool = true
var first_move : bool = true
var points : int = 1

onready var sprite = $Sprite
func _ready():
    if !white:
        sprite.texture = preload("res://Resources/black_pawn.png")

func check_legal(target: Vector2):
    print(square, ", ", target)
    if target == Vector2.INF or target == square:
        return false
    if white:
        if (first_move and target == square - Vector2(0, 2) and
                !get_parent().check_occupied_pawn(square - Vector2(0, 2)) and
                !get_parent().check_occupied_pawn(square - Vector2(0, 1))):
            first_move = false
            return true
        elif target == square - Vector2(0, 1) and !get_parent().check_occupied_pawn(square - Vector2(0, 1)):
            first_move = false
            return true
        elif ((target == square - Vector2(1, 1) and get_parent().check_occupied_enemy(square - Vector2(1, 1), white)) or
              (target == square - Vector2(-1, 1) and get_parent().check_occupied_enemy(square - Vector2(-1, 1), white))):
            return true
    else:
        if (first_move and target == square + Vector2(0, 2) and
                !get_parent().check_occupied_pawn(square + Vector2(0, 2)) and
                !get_parent().check_occupied_pawn(square + Vector2(0, 1))):
            first_move = false
            return true
        elif target == square + Vector2(0, 1) and !get_parent().check_occupied_pawn(square + Vector2(0, 1)):
            first_move = false
            return true
        elif ((target == square + Vector2(1, 1) and get_parent().check_occupied_enemy(square + Vector2(1, 1), white)) or
              (target == square + Vector2(-1, 1) and get_parent().check_occupied_enemy(square + Vector2(-1, 1), white))):
            return true
    return false
