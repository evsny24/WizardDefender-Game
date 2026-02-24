extends CharacterBody2D

func _ready():
	self.visible = false
	set_collision_layer_value(1,false)
func _on_wand_silence():
	set_collision_layer_value(1,true)
	await get_tree().create_timer(1).timeout
	set_collision_layer_value(1,false)

func _on_dragon_1_game_over():
	set_collision_layer_value(1,true)
