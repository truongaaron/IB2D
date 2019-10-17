extends KinematicBody2D

var direction = Vector2()

const LEFT = Vector2(-1, 0)
const RIGHT = Vector2(1, 0)

var pos_x = 0
var initial_pos_x = 0

export var speed = 200
var velocity = Vector2()

func _ready():
	pos_x = position.x + 300
	print(pos_x)
	initial_pos_x = position.x
	
func _physics_process(delta):
	if position.x <= initial_pos_x:
		velocity = RIGHT
	elif position.x > pos_x:
		velocity = LEFT
		
	move_and_slide(velocity.normalized() * speed)
	