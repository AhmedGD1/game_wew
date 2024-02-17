extends Node2D
class_name MoveComponent

@export var speed: float
@export var weight: float

func Move(controller: CharacterBody2D, target: Vector2, deltaTime: float) -> void:
	controller.velocity = controller.velocity.lerp(target * speed, weight * deltaTime)
	controller.move_and_slide()

func NavigationMotion(controller: CharacterBody2D, nav: NavigationAgent2D, target: Vector2, deltaTime: float) -> void:
	nav.target_position = target
	var moveDir: Vector2 = nav.get_next_path_position() - global_position
	controller.velocity = controller.velocity.lerp(moveDir.normalized() * speed, weight * deltaTime)
