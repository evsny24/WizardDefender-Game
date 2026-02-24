extends Control

func _ready():
	$AudioStreamPlayer.play()

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_button_mouse_entered():
	$AudioStreamPlayer2.play()

func _on_button_mouse_exited():
	$AudioStreamPlayer2.play()
