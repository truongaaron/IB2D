extends Control

var scene_path_to_load

onready var mgl = load("res://MainGameLevel.tscn")

func _on_Level1Button_pressed():
	scene_path_to_load = 'res://MainGameLevel.tscn'
	$FadeIn.show()
	$FadeIn.fade_in()
	#get_node("Control/Level1/Potato").respawn_location.x = 1073.3
	#get_node("Control/Level1/Potato").respawn_location.y = 798.465
	#get_node("Control/Level1/Potato").respawn()
	
func _on_Level2Button_pressed():
	get_tree().change_scene('res://MainGameLevel.tscn')
	$FadeIn.show()
	$FadeIn.fade_in()

func _on_Level3Button_pressed():
	pass # Replace with function body.


func _on_Level4Button_pressed():
	pass # Replace with function body.


func _on_Level5Button_pressed():
	pass # Replace with function body.


func _on_Level6Button_pressed():
	pass # Replace with function body.

func _on_FadeIn_fade_finished():
	get_tree().change_scene(scene_path_to_load)

