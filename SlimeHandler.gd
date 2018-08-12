extends Node

var slime_scene = preload("res://enemies//Slime.tscn")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func spawn_slime(pos):
	var slime = slime_scene.instance()
	slime.position = pos
	add_child(slime)
#	bomb.connect("exploded", self, "_on_bomb_exploded")
#	bomb.connect("splashed", self, "_on_bomb_splashed")
#	spawning_bomb = false

func _on_Timer_timeout():
	spwa
