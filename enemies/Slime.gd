extends Area2D

signal died

var chasePlayer = true
var player_body
var tilemap

var altitude = 0
var y_force = 0
var grounded = true
var landed = true
var m_speed = 40
var SPEED = 40
const GRAVITY = -19.8

var dead = false

func set_info(pl, map):
	player_body = pl
	tilemap = map

func _process(delta):
	if (!dead): 
		handle_altitude(delta)
		$AnimatedSprite.position.y = -altitude

	

func _physics_process(delta):
	if (chasePlayer && player_body != null): handle_chase(delta)
	else: $AnimatedSprite.play("default")

func jump():
	if (landed):
		$AnimatedSprite.play("jump")
		y_force = 7.6
		landed = false
		$JumpTimer.wait_time = rand_range(1.4, 3)
		$JumpTimer.start()
		m_speed = SPEED * 3

func handle_chase(delta):
	#MOVEMENT
	var player_position = player_body.get_position()
	var direction = (player_position - position).normalized()
	if (direction.x <= 0): $AnimatedSprite.flip_h = false
	else: $AnimatedSprite.flip_h = true
	var motion = Vector2()
	motion += direction * delta * m_speed
	position += motion

func handle_altitude(delta):
	y_force += GRAVITY * delta
	altitude += y_force
	if altitude <= 0 && tilemap.is_tile_destroyed(position):
		grounded = false
		slime_died()
	if grounded && altitude <= 0:
		altitude = 0
		y_force = 0
		landed = true
		$AnimatedSprite.play("default")
		m_speed = SPEED

func _on_Slime_body_entered(body):
	if (body.name == "Player"):
		if altitude >= body.altitude:
			body.damage()
		else:
			slime_died()

func slime_died():
	if dead: return
	dead = true
	$Hit.play()
	$DeathTimer.start()
	$flesh.emitting = true
	$blood.emitting = true
	$Shadow.visible = false
	if ($CollisionShape2D != null): $CollisionShape2D.queue_free()
	$AnimatedSprite.visible = false

func damage():
	slime_died()

func _on_JumpTimer_timeout():
	jump()

func _on_DeathTimer_timeout():
	emit_signal("died")
	queue_free()
