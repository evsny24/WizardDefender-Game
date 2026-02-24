extends Control

@export var bus_name: String
var bus_index: int

func _ready():
	$AudioStreamPlayer.play()

func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/maingamestuff.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_directions_pressed():
	get_tree().change_scene_to_file("res://scenes/directions.tscn")

func _on_v_box_container_mouse_entered():
	$AudioStreamPlayer2.play()

func _on_v_box_container_mouse_exited():
	$AudioStreamPlayer2.play()

func _on_options_pressed():
	get_tree().change_scene_to_file("res://scenes/options.tscn")
