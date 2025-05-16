extends Area2D

@export var xp = 1
var spr_red = preload("res://Textures/Items/Gems/Gem_red.png")
var spr_green = preload("res://Textures/Items/Gems/Gem_green.png")
var spr_blue = preload("res://Textures/Items/Gems/Gem_blue.png")

var target = null
var speed = -1

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var sound = $sound_collector

func _ready():
	if xp < 5:
		return
	elif xp < 25:
		sprite.texture = spr_blue
	else:
		sprite.texture = spr_red
		
func _physics_process(delta: float) -> void:
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		speed += 2 * delta

func collect():
	sound.play()
	collision.call_deferred("sed", "disabled", true)
	sprite.visible = false
	return xp


func _on_sound_collector_finished() -> void:
	queue_free()
