extends Area2D

export var width = 200
export var height = 200
export var frequency = 0.5
var initial_x = 0
var initial_y = 0
var timeCounter = 0
export var xAxis = Vector2(1,0)
export var yAxis = Vector2(0,1)

func _ready():
	initial_x = position.x
	initial_y = position.y

func _process(delta):
	timeCounter += (delta*3)  
	
	var x = cos(frequency*timeCounter)
	var y = sin(frequency*timeCounter)
	
	
	position.x = initial_x + (x*xAxis.x + y*yAxis.x)*width
	position.y = initial_y +(x*xAxis.y + y*yAxis.y)*height
	
