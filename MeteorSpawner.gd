extends Node

var meteor_scene = preload("res://Props//Meteor.tscn")

var spawn = false
var spawning_meteor = false
var tilemap

func set_tilemap(mao):
	tilemap = mao

func _process(delta):
	if !spawning_meteor && spawn:
		$Timer.wait_time = rand_range(0.1, 0.2)
		$Timer.start()
		spawning_meteor = true


func _on_Timer_timeout():
	for i in range(20):
		var pos = Vector2(randi() % 12, randi() % 12)
		pos.x = (pos.x * 64) + 32
		pos.y = (pos.y * 64) + 32
		if tilemap.is_tile_destroyed(pos) == false:
			spawn_meteor(pos)
			break
	spawning_meteor = false

func spawn_meteor(pos):
	var meteor = meteor_scene.instance()
	meteor.position = pos
	meteor.set_tilemap(tilemap)
	get_parent().add_child(meteor)
	spawning_meteor = false

func set_spawning(b):
	spawn = b
	if (b == false):
		$Timer.stop()
		spawning_meteor = false