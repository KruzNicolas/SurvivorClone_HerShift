extends Button

signal click_end()

func _on_mouse_entered() -> void:
	$sound_hover.play()

func _on_pressed() -> void:
	$sound_click.play()

func _on_sound_click_finished() -> void:
	emit_signal("click_end")
