extends Node

var bomb_scene = preload("res://Props//Bomb.tscn")
var explosion_scene = preload("res://Props//explosion.tscn")
var explosiion_area = preload("res://Props/ExplosioinArea.tscn")
var splash_scene = preload("res://Props//splash.tscn")
var slime_scene = preload("res://enemies//Slime.tscn")

var player

const SPAWN_RANGE = 768
const MAX_BOMBS = 10
const MAX_SLIMES = 20

var nr_slimes = 0
var nr_bombs = 0
var spawning_bomb = false
var spawning_slime = false
var tilemap

var spawn = false

func set_tilemap(map):
	tilemap = map

func set_player(pl):
	player = pl

func _ready():
	pass

func _process(delta):
	if nr_bombs < MAX_BOMBS && !spawning_bomb && nr_slimes > 0:
		$BombTimer.wait_time = rand_range(0.1, 2)
		$BombTimer.start()
		spawning_bomb = true
	
	if nr_slimes < MAX_SLIMES && !spawning_slime && spawn:
		$Timer.wait_time = rand_range(0.1, 2)
		$Timer.start()
		spawning_slime = true

func _on_Timer_timeout():	
	for i in range(20):
		var pos = Vector2(rand_range(32,SPAWN_RANGE-64), rand_range(32, SPAWN_RANGE-64))
		if tilemap.is_tile_destroyed(pos) == false:
			spawn_slime(pos)
			break
	spawning_slime = false


func _on_BombTimer_timeout():
	for i in range(20):
		var pos = Vector2(rand_range(32,SPAWN_RANGE-64), rand_range(32, SPAWN_RANGE-64))
		if tilemap.is_tile_destroyed(pos) == false:
			spawn_bomb(pos)
			break
	spawning_bomb = false

func spawn_bomb(pos):
	nr_bombs += 1
	var bomb = bomb_scene.instance()
	bomb.position = pos
	bomb.set_tilemap(tilemap)
	add_child(bomb)
	bomb.connect("exploded", self, "_on_bomb_exploded")
	bomb.connect("splashed", self, "_on_bomb_splashed")
	spawning_bomb = false

func spawn_slime(pos):
	nr_slimes += 1
	var slime = slime_scene.instance()
	slime.position = pos
	slime.set_info(player, tilemap)
	slime.connect("died", self, "_on_slime_died")
	add_child(slime)
	spawning_slime = false
	

func _on_bomb_exploded(pos):
	nr_bombs -= 1
	tilemap.destroy_tile(pos)
	var explosion = explosion_scene.instance()
	explosion.position = pos
	explosion.emitting = true
	add_child(explosion)
	
	var area = explosiion_area.instance()
	area.position = pos
	add_child(area)

func _on_bomb_splashed(pos):
	nr_bombs -= 1
	var splash = splash_scene.instance()
	splash.position = pos
	splash.emitting = true
	add_child(splash)

func set_spawning(b):
	spawn = b
	if (b == false):
		$Timer.stop()
		spawning_bomb = false
		spawning_slime = false

func _on_slime_died():
	nr_slimes -= 1

func ongoing():
	if nr_slimes > 0: return true
	else: return false