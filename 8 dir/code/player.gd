extends CharacterBody2D

var speed = 400
var a = 0
var dir: String
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite2D


enum State {IDLE, WALKING}

var state = State.IDLE

var dir_move;


func _physics_process(_delta):
	match state:
		State.IDLE:
			Movemnt()
	
	
	#__________________________________________________________
	var lengths = []
	
	for i in 8:
		var i_pos = Vector2(sin(deg_to_rad(i * 45)), cos(deg_to_rad(i * 45)))
		var mouse_pos = (get_global_mouse_position().normalized())
		var length = (i_pos - mouse_pos).length()
		lengths += [length]
	
	set_Dir(lengths.find(lengths.min()))
	Anim()
	



func Movemnt():
	dir_move = Input.get_vector("right","left","up","down")
	
	if dir_move:
		velocity = speed * dir_move

func set_Dir(dir_val: int):
	match dir_val:
		0: dir = "down"
		1, 7: dir = "down_side"
		2, 6: dir = "side"
		3, 5: dir = "up_side"
		4: dir = "up"

func Anim():
	match state:
		State.IDLE:
			if dir_move:
				PlayAnim("run")
			else :
				PlayAnim("idle")
	
	var mouse_dir: Vector2 = sign(get_global_mouse_position() - global_position)
	if mouse_dir.x != 0: animated_sprite.scale.x = mouse_dir.x

func PlayAnim(anim_name:String):
	animated_sprite.play(anim_name + "_" + dir)
