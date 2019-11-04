extends KinematicBody2D

var direction = Vector2()

const UP = Vector2(0, -1)
const DOWN = Vector2(0, 1)

var pos_y = 0
var initial_pos_y = 0

export var speed = 200
var velocity = Vector2()

func _ready():
	pos_y = position.y + 300
	initial_pos_y = position.y
	
func _physics_process(delta):
	if position.y <= initial_pos_y:
		velocity = DOWN
	elif position.y > pos_y:
		velocity = UP
		
	move_and_slide(velocity.normalized() * speed)
	