extends Control

func _ready():
	$RichTextLabel.visible = false
	$RichTextLabel2.visible = false
	$music.play()

#update health
func _on_dragon_update_health(health):
	$healthbar.value = health

func _on_player_game_over():
	$RichTextLabel2.visible = true
	$music.stop()

func _on_dragon_game_over():
	$RichTextLabel.visible = true
	$music.stop()
