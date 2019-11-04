extends KinematicBody2D

#export var speed = 3
export var width = 200
export var height = 200
export var frequency = 0.5
var initial_x = 0
var initial_y = 0
var timeCounter = 0

func _ready():
	initial_x = position.x
	initial_y = position.y

func _process(delta):
	
	timeCounter += (delta*3) # Speed is hardcoded here
							 # I Don't know why the global speed variable doesn't work
	
	var x =cos(frequency*timeCounter)
	var y = sin(frequency*timeCounter)
	
	position.x = initial_x+ (x * width)
	position.y = initial_y+(y * height)
	
	