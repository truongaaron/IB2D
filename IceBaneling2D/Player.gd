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
export var speed = 100
var on_ice = false
var on_oil = false

var respawn_location = Vector2(0,0)

func _ready():
	destination = Vector2(position.x, position.y)
	respawn_location.x = position.x
	respawn_location.y = position.y

func _input(event):
	if Input.is_action_just_pressed("click"):
		destination = get_global_mouse_position()

func _process(delta):
	var collision = move_and_collide(velocity * delta)

	if collision:
		if collision.collider.is_in_group("Donut"):
			velocity = velocity.bounce(collision.normal) * 30
	else:	
		speed = 100
	
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

func _on_IceFloor_body_entered(body):
	if body.name == "Potato":
		speed = 100
		on_ice = true

func _on_IceFloor_body_exited(body):
	if body.name == "Potato":
		speed = 200
		on_ice = false

func _on_OilyFloor_body_entered(body):
	if body.name == "Potato":
		speed = 200
		on_oil = true

func _on_OilyFloor_body_exited(body):
	if body.name == "Potato":
		speed = 200
		on_oil = false

func respawn():
	set_position(respawn_location)
	
func _on_Potato_Area_Entered(area):
	if area.is_in_group("Enemy"):
		destination.x = respawn_location.x
		destination.y = respawn_location.y
		respawn()
	if area.is_in_group("Checkpoint"):
		respawn_location.x = area.position.x
		respawn_location.y = area.position.y

