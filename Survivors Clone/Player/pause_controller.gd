extends Node

@onready var pausePanel = get_node("%PausePanel")

signal paused
signal unpaused

func _process(delta) -> void:
	if Input.is_action_just_pressed("escape"):
		pause_or_unpause()
		
func pause_or_unpause():
	if get_tree().paused == true:
		unpause()
	elif get_tree().paused == false:
		pause()
	
func pause():
	pausePanel.visible = true
	emit_signal("paused")
	var tween = pausePanel.create_tween()
	tween.tween_property(pausePanel, "position", Vector2(220, 105), 1.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
	get_tree().paused = true
	
func unpause():
	emit_signal("unpaused")
	var tween = pausePanel.create_tween()
	tween.tween_property(pausePanel, "position", Vector2(220, -176), 0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	tween.play()
	await tween.finished
	pausePanel.visible = false
	get_tree().paused = false

func _on_btn_resume_click_end() -> void:
	unpause()

func _on_btn_menu_click_end() -> void:
	get_tree().paused = false
	var _level = get_tree().change_scene_to_file("res://TitleScreen/menu.tscn")
