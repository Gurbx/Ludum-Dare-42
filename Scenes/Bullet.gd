extends Area2D

var direction = Vector2(0,0)
var speed = 300

func _process(delta):
	var motion = Vector2()
	direction.y = 1
	motion += direction * delta * speed
	position += motion

func set_target(new_dir, spe):
	speed = spe
	direction = new_dir.normalized()

func _on_LifeTime_timeout():
	queue_free()

func _on_Bullet_body_entered(body):
	if body.name == "Player":
		body.damage()


func _on_Bullet_area_entered(area):
	if area.has_method("damage"):
		area.damage()
