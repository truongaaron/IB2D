extends Area2D

var distance = 0
var pos_x = 0
var initial_pos_x = 0

var switch = false

export var speed = 4
var velocity = Vector2()

func _ready():
	pos_x = position.x + 300
	initial_pos_x = position.x
	
func _physics_process(delta):
	if !switch:
		position.x += distance+speed*delta
		if position.x > pos_x:
			switch = true
	elif switch:
		distance = 0
		position.x += distance-speed*delta
		if position.x <= initial_pos_x:
			switch = false
