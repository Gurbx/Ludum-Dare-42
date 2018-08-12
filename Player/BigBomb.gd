extends Area2D

signal boss_damaged

var triggered = false
var motion = Vector2()
var direction = Vector2()
var speed = 100
var grav = 50



func _process(delta):
	if triggered:
		direction.y = -1
		motion += direction * delta * speed
		position += motion
		speed -= grav*delta


func _on_BigBomb_area_entered(area):
	if area.name == "impact_area":
		triggered = true
		$Timer.start()
		$SpawnEffect.emitting = true
		$AudioStreamPlayer2D.play()


func _on_Timer_timeout():
	emit_signal("boss_damaged")
	queue_free()
