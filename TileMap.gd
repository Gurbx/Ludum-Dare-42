extends TileMap

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

#DESTROY TILE TEST
#func _input(event):
#	if event.is_action_pressed("mouse_lclick"):
#		var mouse_pos = get_global_mouse_position()
#		destroy_tile(mouse_pos)


func is_tile_destroyed(pos):
	if get_cellv(world_to_map(pos)) == -1:
		return true
	elif get_cellv(world_to_map(pos)) == 2:
		return true
	else: return false



func destroy_tile(pos):
	var tile = world_to_map(pos)
	
	var above = get_cell(tile.x, tile.y -1)
	if above != -1 && above != 2:
		set_cellv(tile, 2)
	else:
		set_cellv(tile, -1)
	
	var bellow = get_cell(tile.x, tile.y +1)
	if bellow == 2:
		set_cell(tile.x, tile.y+1, -1)
