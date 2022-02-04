extends Node2D

var tile_size : int = 22
var board_offset : int = 40
var clicksquare : Vector2
var releasesquare : Vector2
var picked : Node2D

var board = []
func populate_board():
    for i in range(8):
        board.append([])
        for j in range(8):
            board[i].append(Rect2(board_offset + tile_size * i,
                            board_offset + tile_size * j,
                            tile_size, tile_size))

func align(child):
    child.position = board[child.square.x][child.square.y].position.snapped(Vector2.ONE * tile_size)
    child.position += 7 * Vector2.ONE

func _ready():
    populate_board()
    for child in get_children():
        child.square = find_square(child.position)
        align(child)

func _unhandled_input(event):
    if event.is_action_pressed("Click"):
        clicksquare = find_square(event.position)
        print("Clicked ", clicksquare)
        for child in get_children():
            if clicksquare == child.square:
                picked = child
                print("Picked ", picked.name)
    elif event.is_action_released("Click"):
        releasesquare = find_square(event.position)
        if picked != null and picked.check_legal(releasesquare):
            picked.square = releasesquare
            align(picked)
            capture(releasesquare, picked.white)
            print(picked.get_class())
            if picked.get_class() == "Pawn" and picked.square.y == 0 and picked.white:
                var queen = get_node("Queen").duplicate()
                add_child(queen)
                queen.square = picked.square
                queen.white = true
                align(queen)
                picked.queue_free()
            elif picked.get_class() == "Pawn" and picked.square.y == 7 and !picked.white:
                var queen = get_node("Queen2").duplicate()
                add_child(queen)
                queen.square = picked.square
                queen.white = false
                align(queen)
                picked.queue_free()
            picked = null
        else:
            print("Illegal Move.")

func check_occupied(square : Vector2, white : bool):
    for child in get_children():
        if child.square == square and child.white == white:
            return true
    return false

func check_occupied_enemy(square : Vector2, white : bool):
    for child in get_children():
        if child.square == square and child.white != white:
            return true
    return false

func check_occupied_pawn(square : Vector2):
    for child in get_children():
        if child.square == square:
            return true
    return false

func capture(square : Vector2, white : bool):
    for child in get_children():
        if child.square == square and child.white != white:
            if white:
                get_parent().white_score += child.points
            else:
                get_parent().black_score += child.points
            child.queue_free()

func find_square(point : Vector2):
    for i in range(8):
        for j in range(8):
            if board[i][j].has_point(point):
                return Vector2(i, j)
    return Vector2.INF

func _on_King_WhiteKingCastle() -> void:
    get_node("King's Rook").square = Vector2(5, 7)
    align(get_node("King's Rook"))

func _on_King_WhiteQueenCastle() -> void:
    get_node("Queen's Rook").square = Vector2(3, 7)
    align(get_node("Queen's Rook"))

func _on_King2_BlackQueenCastle() -> void:
    get_node("Queen's Rook2").square = Vector2(3, 0)
    align(get_node("Queen's Rook2"))

func _on_King2_BlackKingCastle() -> void:
    get_node("King's Rook2").square = Vector2(5, 0)
    align(get_node("King's Rook2"))
