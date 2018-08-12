extends Node

var bullet_scene = preload("res://Scenes//Bullet.tscn")

var spawn_position = Vector2(0,0)
var spawning = false
var to_spawn = 0

var can_spawn = false

func _ready():
	spawn_position.y = -100

func spawn():
	var type = randi() % 2
	print(type)
	if type == 0:
		spawn_bullets_line()
	if type == 1:
		spawn_bullets_barrage()


func spawn_bullets_line():
	for i in range(12):
		var pos = spawn_position
		pos.x = i*64 + 32
		var speed = 150 + rand_range(0, 100)
		spawn_bullet(pos, speed, Vector2(0,-1))

func spawn_bullets_barrage():
	to_spawn = 10
	$Timer.wait_time = 0.1
	$Timer.start()
	


func spawn_bullet(pos, speed, direction):
	var bullet = bullet_scene.instance()
	bullet.position = pos
	bullet.set_target(direction, speed)
	get_parent().add_child(bullet)
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Timer_timeout():
	to_spawn -= 1
	var pos = spawn_position
	pos.x = randi() % 12 * 64 + 32
	spawn_bullet(pos, 350, Vector2(0,-1))
	
	if to_spawn > 0:
		$Timer.wait_time = rand_range(0.25, 0.5)
		$Timer.start()
	else:
		spawning = false
		$Timer.stop()
	


func _on_Wave_Timer_timeout():
	if can_spawn:
		spawn()
	$Wave_Timer.wait_time = rand_range(4,8)
	$Wave_Timer.start()
