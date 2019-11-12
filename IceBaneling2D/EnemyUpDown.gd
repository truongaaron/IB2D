extends Area2D

var distance = 0
var pos_y = 0
var initial_pos_y = 0

var switch = false

export var speed = 4
var velocity = Vector2()
export(Curve) var tweening; 

func _ready():
	pos_y = position.y + 300
	initial_pos_y = position.y
	
func _physics_process(delta):
	#tweening.interpolate(time);
	if !switch:
		position.y += distance+speed
		if position.y > pos_y:
			switch = true
	elif switch:
		distance = 0
		position.y += distance-speed
		if position.y <= initial_pos_y:
			switch = false
