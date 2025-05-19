extends AudioStreamPlayer

func _on_player_playerdeath() -> void:
	playing = false

func _on_player_paused() -> void:
	playing = false

func _on_player_unpaused() -> void:
	playing = true
