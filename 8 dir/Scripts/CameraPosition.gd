extends Node2D

@export var camera: Camera2D

func _physics_process(_delta: float) -> void:
	if (!is_instance_valid(camera)):
		return
	var mouse_pos: Vector2 = get_global_mouse_position()
	camera.global_position = (mouse_pos - (camera.position / 2.0)) / 10.0
