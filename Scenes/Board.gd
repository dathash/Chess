extends Node2D

var white_score : int = 0
var black_score : int = 0

onready var label = $RichTextLabel

func _process(_delta):
    label.text = str(white_score) + " | " + str(black_score)
