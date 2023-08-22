extends KinematicBody2D

#onready var sprite: Sprite = get_node("sprite")

var velocity: Vector2

export(int) var move_speed
export(int) var run_speed
export(int) var gravity_speed

func _physics_process(delta: float) -> void:
	move()
	jump(delta)
	velocity = move_and_slide(velocity)
	
func move() -> void:
	if Input.get_action_strength("ui_select"):
		velocity.x = run_speed * get_direction()
	else:
		velocity.x = move_speed * get_direction()
		
func jump(delta: float) -> void:
	velocity.y += delta * gravity_speed

func get_direction() -> float:
	return Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
