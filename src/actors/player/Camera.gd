extends Camera2D

export var camera_back_tolerance = 50

func _auto_set_limits():
	limit_left = 0
	limit_right = 0
	limit_bottom = 0

	var tilemaps = get_tree().get_nodes_in_group("tilemap")
	for tilemap in tilemaps:
		if tilemap is TileMap:
			var used = tilemap.get_used_rect()
			limit_left = min(used.position.x * tilemap.cell_size.x, limit_left)
			limit_right = max(used.end.x * tilemap.cell_size.x, limit_right)
			limit_bottom = max(used.end.y * tilemap.cell_size.y, limit_bottom)

func _update_limit_left():
	var _current_top_x: int = ceil(get_camera_screen_center().x - get_viewport_rect().size.x / 2)
	var _new_limit_left: int = _current_top_x - camera_back_tolerance
	limit_left = max(limit_left, _new_limit_left)

func _ready(): 
	_auto_set_limits()

func _physics_process(delta: float) -> void:
	_update_limit_left()
