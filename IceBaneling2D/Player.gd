extends KinematicBody2D

var location = Vector2(0, 0)
var velocity = Vector2(0, 0)
var acceleration = Vector2(0, 0)
var maxspeed = 4
var maxforce = .1

export var default_friction = 0.5
export var ice_friction = 0.01
export var oil_friction = .0001

var destination = Vector2()
var on_ice_destination = Vector2()

var gap = Vector2()
export var speed = 200
var on_ice = false
var on_oil = false

var checkpoint = preload("res://checkpoint.gd")

var respawn_location = Vector2(0,0)

func _ready():
	destination = Vector2(position.x, position.y)
	respawn_location.x = position.x
	respawn_location.y = position.y

func _input(event):
	if Input.is_action_just_pressed("click"):
		destination = get_global_mouse_position()
		seek(Vector2(destination.x, destination.y))
		update()

func _process(delta):
	var old_way = false
	if old_way:
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
	else:
		
		gap = Vector2(destination.x - position.x, destination.y - position.y)
		var direction = gap.normalized()
		if gap.length() < 1:
			direction = gap
		var desired_velocity = direction*speed
		var friction = default_friction
		if on_ice:
			friction = ice_friction
		elif on_oil:
			friction = oil_friction
			
		velocity = friction*desired_velocity + (1-friction)*velocity
		
		move_and_slide(velocity)
		
		
			
func update():
	#velocity += acceleration
	#limit(maxspeed, velocity)
	#location += velocity
	#acceleration *= 0
	pass
	
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
		speed = 180
		on_ice = true

func _on_IceFloor_body_exited(body):
	if body.name == "Potato":
		speed = 150
		on_ice = false

func _on_OilyFloor_body_entered(body):
	if body.name == "Potato":
		speed = 300
		on_oil = true

func _on_OilyFloor_body_exited(body):
	if body.name == "Potato":
		speed = 150
		on_oil = false
	

func respawn():
	set_position(respawn_location)
	
func _on_Potato_Area_Entered(area):
	if area.is_in_group("Enemy"):
		respawn()
	if area.is_in_group("checkpoint"):
		respawn_location.x = area.position.x
		respawn_location.y = area.position.y
		
