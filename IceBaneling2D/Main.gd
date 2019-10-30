extends Control

onready var sprite = preload("res://ClickIndicator.tscn")
var destination = Vector2()
var s = null

func _ready():
	s = sprite.instance()
	
func _input(event):
	if Input.is_action_just_pressed("click"):
		var pos = get_global_mouse_position()
		s.position.x = pos.x
		s.position.y = pos.y
		add_child(s)
	
