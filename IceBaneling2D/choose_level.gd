extends Control

var scene_path_to_load

var player = load("res://Player.gd").new()

func _on_Level1Button_pressed():
	scene_path_to_load = 'res://Level1.tscn'
	$FadeIn.show()
	$FadeIn.fade_in()
	
func _on_Level2Button_pressed():
	scene_path_to_load = 'res://Level2.tscn'
	$FadeIn.show()
	$FadeIn.fade_in()

func _on_Level3Button_pressed():
	scene_path_to_load = 'res://Level3.tscn'
	$FadeIn.show()
	$FadeIn.fade_in()

func _on_Level4Button_pressed():
	scene_path_to_load = 'res://Level4.tscn'
	$FadeIn.show()
	$FadeIn.fade_in()

func _on_Level5Button_pressed():
	scene_path_to_load = 'res://Level5.tscn'
	$FadeIn.show()
	$FadeIn.fade_in()

func _on_Level6Button_pressed():
	scene_path_to_load = 'res://Level6.tscn'
	$FadeIn.show()
	$FadeIn.fade_in()
	
func _on_BackButton_pressed():
	scene_path_to_load = 'res://TitleScreen.tscn'
	$FadeIn.show()
	$FadeIn.fade_in()

func _on_FadeIn_fade_finished():
	get_tree().change_scene(scene_path_to_load)

