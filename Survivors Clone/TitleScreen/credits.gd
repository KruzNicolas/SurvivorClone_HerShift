extends Control

func _on_button_back_click_end() -> void:
	var menu = get_tree().change_scene_to_file("res://TitleScreen/menu.tscn")
