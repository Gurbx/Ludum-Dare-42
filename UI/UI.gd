extends CanvasLayer

signal player_dead

var health = 3

var boss_health = 3

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func boss_damaged():
	if boss_health == 3: $boss/bar3.destroy()
	if boss_health == 2: $boss/bar2.destroy()
	if boss_health == 1:
		$boss/bar.destroy()
		$boss/WinTimer.start()
	boss_health -= 1
	$boss/BossDamage.play()

func _on_Player_damaged():
	if (health == 3): $Life/Heart3.destroy()
	if (health == 2): $Life/Heart2.destroy()
	if (health == 1): 
		$Life/Heart.destroy()
		$Life/DeathTimer.start()
		emit_signal("player_dead")
	health -= 1


func _on_DeathTimer_timeout():
	GameHandler.game_over()


func _on_WinTimer_timeout():
	GameHandler.win()
