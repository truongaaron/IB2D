extends KinematicBody2D

var direction = Vector2()

const UP = Vector2(0, -1)
const DOWN = Vector2(0, 1)
const LEFT = Vector2(-1, 0)
const RIGHT = Vector2(1, 0)

var pos_y = 0
var initial_pos_y = 0

var speed = 200
var velocity = Vector2()

func _ready():
	pos_y = position.y + 300
	print(pos_y)
	initial_pos_y = position.y
	
func _physics_process(delta):
	print(position.y , " " ,initial_pos_y)
	if position.y <= initial_pos_y:
		velocity = DOWN
	elif position.y > pos_y:
		velocity = UP
		
	move_and_slide(velocity.normalized() * speed)
	