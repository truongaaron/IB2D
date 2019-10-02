extends KinematicBody2D

var destination = Vector2()
var gap = Vector2()
var speed = null

func _ready():
	speed = 100
	destination = Vector2(position.x, position.y)
	
func _process(delta):
	if position != destination:
		gap = Vector2(destination.x - position.x, destination.y - position.y)
		move_and_slide(gap.normalized() * speed)
		if gap.abs() < Vector2(1,1):
			set_position(destination)
	if destination == position:
		move_and_slide(gap*0)
	
	
func _input(event):
	if Input.is_action_just_pressed("click"):
		destination = get_global_mouse_position()

func _on_IceFloor_body_entered(body):
	if body.name == "Potato":
		speed = 200


func _on_IceFloor_body_exited(body):
	if body.name == "Potato":
		speed = 100
