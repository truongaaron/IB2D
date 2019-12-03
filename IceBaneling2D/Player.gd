extends KinematicBody2D

var location = Vector2(0, 0)
var velocity = Vector2(0, 0)
var acceleration = Vector2(0, 0)
var maxspeed = 4
var maxforce = .1

var frictions = Array()

export var default_friction = 0.5
export var ice_friction = 0.01
export var oil_friction = .0001
export var donut_bounce = 5
export var speed = 200
var destination = Vector2()
var on_ice_destination = Vector2()

var gap = Vector2()
var on_ice = false
var on_oil = false

var respawn_location = Vector2(0,0)

func _ready():
	destination = Vector2(position.x, position.y)
	respawn_location.x = position.x
	respawn_location.y = position.y
	frictions.append(default_friction)

func _input(event):
	if Input.is_action_just_pressed("click"):
		destination = get_global_mouse_position()

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	#print(frictions.front())
	if collision:
		if collision.collider.is_in_group("Donut"):
			velocity = velocity.bounce(collision.normal)  * donut_bounce
	
	gap = Vector2(destination.x - position.x, destination.y - position.y)
	var direction = gap.normalized()
	if gap.length() < 1:
		direction = gap
	var desired_velocity = direction*speed
	var friction = default_friction
	
	
	if on_oil:
		friction = oil_friction
	elif on_ice:
		friction = ice_friction

	velocity = friction*desired_velocity + (1-friction)*velocity
	
	move_and_slide(velocity*delta)

func _on_IceFloor_body_entered(body):
	if body.name == "Potato":
		on_ice = true

func _on_IceFloor_body_exited(body):
	if body.name == "Potato":
		on_ice = false

func _on_OilyFloor_body_entered(body):
	if body.name == "Potato":
		on_oil = true

func _on_OilyFloor_body_exited(body):
	if body.name == "Potato":
		on_oil = false

func respawn():
	set_position(respawn_location)
	
func _on_Potato_Area_Entered(area):
	if area.is_in_group("Enemy"):
		destination.x = respawn_location.x
		destination.y = respawn_location.y
		respawn()
	if area.is_in_group("Checkpoint"):
		frictions.push_front(default_friction)
		respawn_location.x = area.position.x
		respawn_location.y = area.position.y
	if area.is_in_group("Floor"):
		if area.is_in_group("Oily"):
			frictions.push_front(oil_friction)
		if area.is_in_group("Ice"):
			frictions.push_front(ice_friction)
	if area.is_in_group("Finish"):
		if area.is_in_group("toLevel2"):
			get_tree().change_scene('res://Level2.tscn')
		if area.is_in_group("toLevel3"):
			get_tree().change_scene('res://Level3.tscn')
		if area.is_in_group("toLevel4"):
			get_tree().change_scene('res://Level4.tscn')
		
func _on_Area2D_area_exited(area):
	if area.is_in_group("Floor"):
		frictions.pop_front()