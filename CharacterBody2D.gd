extends CharacterBody2D

const SPEED = 64
var left_mouse_pressed = false
var left_mouse_direction = Vector2.ZERO

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") + left_mouse_direction
	velocity = direction * SPEED

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			left_mouse_pressed = event.pressed
			left_mouse_direction = Vector2.ZERO # Initialization
	elif event is InputEventMouseMotion:
		if left_mouse_pressed and !event.relative.is_normalized():
			left_mouse_direction = event.relative.limit_length()
	#else: print(event)
