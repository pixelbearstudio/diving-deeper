extends KinematicBody2D

onready var sprite: Sprite = get_node("Texture")

var velocity: Vector2

export(int) var move_speed
export(int) var run_speed
export(int) var gravity_speed
export(int) var stamina

func _physics_process(delta: float) -> void:
	move()
	calc_stamina()
	jump(delta)
	velocity = move_and_slide(velocity)
	sprite.animate(velocity, stamina)
	
func calc_stamina() -> void:
	# Se a stamina não estivar no máximo e o player estiver parado ela começa a recuperar
	if stamina < 150 and velocity.x == 0:
		stamina += 0.0005
	# Se a stamina não estivar no máximo, o player estiver andando e não tentando correr ela começa a recuperar mais lento
	elif stamina < 150 and velocity.x != 0 and Input.get_action_strength("ui_shift") != 1:
		stamina += 0.00025
	
func move() -> void:
	if velocity.x != 0 and Input.get_action_strength("ui_shift") and stamina > 0:
		velocity.x = run_speed * get_direction()
		stamina -= 0.05
	else:
		velocity.x = move_speed * get_direction()
			
func jump(delta: float) -> void:
	velocity.y += delta * gravity_speed

func get_direction() -> float:
	return Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
