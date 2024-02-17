extends Node2D

@onready var cemra = $Camera2D

func _physics_process(_delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	cemra.global_position = (mouse_pos - (cemra.position/2))/10
