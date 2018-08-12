extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var player
var player_in_area = false
var tilemap

func _ready():
	$AnimationPlayer.play("Fall")

func set_tilemap(map):
	tilemap = map


func _on_ExplosionTimer_timeout():
	queue_free()


func _on_SpawnTimer_timeout():
	$Sprite.hide()
	$shadow.queue_free()
	$HitSound.play()
	$explosion.emitting = true
	$ExplosionTimer.start()
	tilemap.destroy_tile(position)
	if player_in_area:
		player.damage()


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		player = body
		player_in_area = true


func _on_Area2D_body_exited(body):
	if body.name == "Player":
		player_in_area = false
