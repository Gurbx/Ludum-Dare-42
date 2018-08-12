extends Node2D

export (int) var start_time = 0

func _ready():
	print(start_time)
	$AnimationPlayer.advance(start_time)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pas

func destroy():
	$AnimationPlayer.play("die")
	$Timer.start()


func _on_Timer_timeout():
	queue_free()
