extends Control

var level = "res://World/world.tscn"


func _on_button_play_click_end() -> void:
	var _level = get_tree().change_scene_to_file(level)


func _on_button_exit_click_end() -> void:
	get_tree().quit()

func _on_button_credits_click_end() -> void:
	var credtis = get_tree().change_scene_to_file("res://TitleScreen/credits.tscn")

func _on_button_git_hub_pressed() -> void:
	OS.shell_open("https://github.com/KruzNicolas/SurvivorClone_HerShift")

func _on_button_youtube_pressed() -> void:
	OS.shell_open("www.youtube.com")
