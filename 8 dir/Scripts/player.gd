extends CharacterBody2D
class_name Player

enum PlayerStates {IDLE, HIT, ROLL, DEATH}

@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var moveComponent: MoveComponent = %MoveComponent as MoveComponent

@export var speed: float = 70.0
@export var weight: float = 16.0

var dir: String = "down"
var state = PlayerStates.IDLE

var x: float
var y: float

func _process(_delta: float) -> void:
	match (state):
		PlayerStates.IDLE:
			SetDir()
			HandleInput()
	Anim()

func _physics_process(delta) -> void:
	match (state):
		PlayerStates.IDLE:
			moveComponent.Move(self, Vector2(x, y), delta)

func HandleInput() -> void:
	x = Input.get_axis("left", "right")
	y = Input.get_axis("up", "down")

func SetDir():
	var lengths: Array[Variant]
	
	for i in 8:
		var iPos = Vector2(sin(deg_to_rad(i * 45)), cos(deg_to_rad(i * 45)))
		var mouse_pos = (get_global_mouse_position() - global_position).normalized()
		var length = (iPos - mouse_pos).length()
		lengths += [length]
	
	match lengths.find(lengths.min()):
		0: dir = "down"
		1, 7: dir = "down_side"
		2, 6: dir = "side"
		3, 5: dir = "up_side"
		4: dir = "up"

func Anim():
	match (state):
		PlayerStates.IDLE:
			if (x != 0 || y != 0):
				PlayAnim("run")
			else :
				PlayAnim("idle")
	
	var mouse_dir: Vector2 = (get_global_mouse_position() - global_position).normalized()
	if (mouse_dir.x != 0): animated_sprite.scale.x = sign(mouse_dir.x)

func PlayAnim(anim_name:String): animated_sprite.play(anim_name + "_" + dir)
func ChangeState(newState: PlayerStates) -> void: state = newState








