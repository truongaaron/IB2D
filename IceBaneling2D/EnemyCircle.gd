extends KinematicBody2D

#export var speed = 3
export var width = 200
export var height = 200

var timeCounter = 0

func _process(delta):
	print(delta)
	timeCounter += (delta*3) # Speed is hardcoded here
							 # I Don't know why the global speed variable doesn't work
	
	var x = cos(timeCounter)
	var y = sin(timeCounter)
	
	print(x)
	print(" ")
	print(y)
	
	position.x = (x * width)
	position.y = (y * height)
	
	