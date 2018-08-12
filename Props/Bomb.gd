extends RigidBody2D

signal exploded(pos)
signal splashed(pos)

const GRAVITY = -19.8
var altitude = 0
var y_force = 0
var grounded = true
var tilemap

func set_tilemap(map):
	tilemap = map

func _ready():
	pass

func _physics_process(delta):
	rotation = 0

func _process(delta):
	handle_altitude(delta)
	$Sprite.position.y = -altitude

func handle_altitude(delta):
	y_force += GRAVITY * delta
	altitude += y_force
	if altitude <= 0 && tilemap.is_tile_destroyed(position):
		grounded = false
		splash()
	if grounded && altitude <= 0:
		altitude = 0
		y_force = 0

func push(from_point, force):
	var direction = (from_point - global_position).normalized()
	y_force = 7
	apply_impulse(Vector2(0,0), -direction*force)
	$Area2D.queue_free()
	$CollisionShape2D.queue_free()
	$Timer.start()
	$AnimationPlayer.play("fuse")
	$Activated.play()

#func _on_Area2D_body_entered(body):
#	if body.name == "Player":
#		push(body.position, 320)


func _on_Timer_timeout():
	explode()

func explode():
	emit_signal("exploded", position)
	queue_free()

func splash():
	emit_signal("splashed", position)
	queue_free()

func _on_Area2D_area_entered(area):
	if area.name == "impact_area":
		push(area.get_parent().position, 320)
