extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass



func game_over():
	get_tree().change_scene("res://Scenes/GameOver.tscn")
#	get_node("/root/SceneHandler").goto_scene("res://Scenes/GameOver.tscn")

func win():
	get_tree().change_scene("res://Scenes/Win.tscn")
#	get_node("/root/SceneHandler").goto_scene("res://Scenes/Win.tscn")

