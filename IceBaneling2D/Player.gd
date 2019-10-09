extends KinematicBody2D

var location = Vector2(0, 0)
var velocity = Vector2(0, 0)
var acceleration = Vector2(0, 0)
var maxspeed = 4
var maxforce = .1


var destination = Vector2()
var on_ice_destination = Vector2()

var gap = Vector2()
var speed = null
var on_ice = false

func _ready():
	speed = 100
	destination = Vector2(position.x, position.y)

func _input(event):
	if Input.is_action_just_pressed("click"):
		destination = get_global_mouse_position()
		seek(Vector2(destination.x, destination.y))
		update()

func _process(delta):
	if on_ice and position != on_ice_destination:
		gap = Vector2(on_ice_destination.x - position.x, on_ice_destination.y - position.y)
		move_and_slide(gap.normalized() * speed)
		if gap.abs() < Vector2(1,1):
			set_position(on_ice_destination)
	if on_ice_destination == position:
		move_and_slide(gap*0)
		
	if position != destination:
		gap = Vector2(destination.x - position.x, destination.y - position.y)
		move_and_slide(gap.normalized() * speed)
		if gap.abs() < Vector2(1,1):
			set_position(destination)
	if destination == position:
		move_and_slide(gap*0)

func update():
	velocity += acceleration
	limit(maxspeed, velocity)
	location += velocity
	acceleration *= 0

func applyForce(force):
	acceleration += force

func seek(target):
	var desired = Vector2(0, 0)
	desired = target - location
	desired = desired.normalized()
	desired *= maxspeed
	var steer = Vector2(0, 0)
	steer = desired - velocity
	limit(maxforce, steer)
	applyForce(steer)

func limit(value, vec):
	var length = vec.length()
	
	if length > value:
		var ratio = value/length
		vec.x *= ratio
		vec.y *= ratio

func _on_IceFloor_body_entered(body):
	if body.name == "Potato":
		on_ice = true

func _on_IceFloor_body_exited(body):
	if body.name == "Potato":
		speed = 150
		on_ice = false