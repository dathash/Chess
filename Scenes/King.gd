extends Node2D

var square : Vector2
export var white : bool = true
var castling : bool = true
var points : int = 100

signal WhiteQueenCastle
signal WhiteKingCastle
signal BlackQueenCastle
signal BlackKingCastle

onready var sprite = $Sprite
func _ready():
    if !white:
        sprite.texture = preload("res://Resources/black_king.png")

func check_legal(target: Vector2):
    if target == Vector2.INF or target == square:
        return false
    if get_parent().check_occupied(target, white):
        return false
    var movement = target - square
    if white:
        if castling and movement == Vector2(2, 0):
            if (!get_parent().check_occupied(square + Vector2(1, 0), white) and !get_parent().check_occupied(square + Vector2(2, 0), white) and
                get_parent().get_node("King's Rook").square == square + Vector2(3, 0)):
                castling = false
                emit_signal("WhiteKingCastle")
                return true
        elif castling and movement == Vector2(-2, 0):
            if (!get_parent().check_occupied(square + Vector2(-1, 0), white) and !get_parent().check_occupied(square + Vector2(-2, 0), white) and
                    !get_parent().check_occupied(square + Vector2(-3, 0), white) and
                    get_parent().get_node("Queen's Rook").square == square + Vector2(-4, 0)):
                castling = false
                emit_signal("WhiteQueenCastle")
                return true
    else:
        if castling and movement == Vector2(2, 0):
            if (!get_parent().check_occupied(square + Vector2(1, 0), white) and !get_parent().check_occupied(square + Vector2(2, 0), white) and
                get_parent().get_node("King's Rook2").square == square + Vector2(3, 0)):
                castling = false
                emit_signal("BlackKingCastle")
                return true
        elif castling and movement == Vector2(-2, 0):
            if (!get_parent().check_occupied(square + Vector2(-1, 0), white) and !get_parent().check_occupied(square + Vector2(-2, 0), white) and
                    !get_parent().check_occupied(square + Vector2(-3, 0), white) and
                    get_parent().get_node("Queen's Rook2").square == square + Vector2(-4, 0)):
                castling = false
                print("EMITTING")
                emit_signal("BlackQueenCastle")
                return true

    if abs(movement.x) > 1 or abs(movement.y) > 1:
        return false
    castling = false
    return true
