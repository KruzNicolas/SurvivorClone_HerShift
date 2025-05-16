extends CharacterBody2D

@export var movement_speed = 20.0
@export var hp = 100
@export var knockback_recovery = 3.5
@export var xp = 1
var knockback = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")
@onready var loot_base = get_tree().get_first_node_in_group("loot")
@onready var sprite = $Sprite2D
@onready var anim = $AnimationPlayer
@onready var sound_hit = $sound_hit

var death_animation = preload("res://Enemy/explosion.tscn")
var xp_gem = preload("res://Objects/xp_gem.tscn")

signal remove_from_array(object)

func _ready():
	anim.play("walk")

func _physics_process(_delta):
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movement_speed
	velocity += knockback
	move_and_slide()
	if direction.x > 0.1:
		sprite.flip_h = false
	elif direction.x < -0.1:
		sprite.flip_h = true

func death():
	emit_signal("remove_from_array", self)
	var enemy_death = death_animation.instantiate()
	enemy_death.scale = sprite.scale + Vector2(1,1)
	enemy_death.global_position = global_position
	get_parent().call_deferred("add_child", enemy_death)
	var new_gem = xp_gem.instantiate()
	new_gem.global_position = global_position
	new_gem.xp = xp
	loot_base.call_deferred("add_child", new_gem)
	queue_free()

func _on_hurt_box_hurt(damage, angle, knockback_amount):
	hp -= damage
	knockback = angle * knockback_amount
	if hp <= 0:
		death()
	else:
		sound_hit.play()
