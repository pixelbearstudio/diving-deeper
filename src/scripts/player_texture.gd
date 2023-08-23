extends Sprite

onready var animation: AnimationPlayer = get_node("%AnimationPlayer")
var stm

func animate(velocity: Vector2, stamina: int) -> void:
	stm = stamina
	verify_orientation(velocity.x)
	horizontal_behavior(velocity.x)
	
func verify_orientation(speed: float) -> void:
	if speed > 0:
		flip_h = false
	elif speed < 0:
		flip_h = true
	
func horizontal_behavior(speed: float) -> void:
	if speed != 0 and Input.get_action_strength("ui_shift") and stm > 0:
		animation.play("run")
		return
	elif speed != 0:
		animation.play("move")
		return
	else:
		animation.play("idle")
		return
