extends Camera2D

@export var min_zoom = Vector2(0.5, 0.5) # Farthest zoom
@export var max_zoom = Vector2(4.0, 4.0) # Nearest zoom
@export var zoom_factor = Vector2(0.1, 0.1) # Zoom steps
@export var rotation_base = 0.01

var translation_base = -zoom # Camera translation is mouse-negative
var _translation_factor = translation_base / zoom # Default is -1
var middle_mouse_pressed = false
var right_mouse_pressed = false

func _set_zoom_level(factor: Vector2) -> void:
	zoom = clamp(zoom + factor, min_zoom, max_zoom) # Clamps zoom
	_translation_factor = translation_base / zoom # Updates _translation_factor

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			_set_zoom_level(zoom_factor)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			_set_zoom_level(-zoom_factor)
		elif event.button_index == MOUSE_BUTTON_MIDDLE:
			middle_mouse_pressed = event.pressed
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			right_mouse_pressed = event.pressed
		#else: print(event)
	elif event is InputEventMouseMotion:
		if middle_mouse_pressed:
			var center = get_viewport_rect().get_center()
			rotate((
				event.relative.x * (1 if event.position.y > center.y else -1) # Clockwise if above center
				 + event.relative.y * (1 if event.position.x <= center.x else -1) # Clockwise if left sided
				) * rotation_base)
		if right_mouse_pressed:
			translate(event.relative * _translation_factor)
	#else: print(event)
