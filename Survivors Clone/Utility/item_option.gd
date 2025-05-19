extends ColorRect

@onready var labelName = $label_name
@onready var labelDescription = $label_description
@onready var labelLevel = $label_level
@onready var itemIcon = $ColorRect/ItemIcon

var mouse_over = false
var item = null
@onready var player = get_tree().get_first_node_in_group("player")

signal selected_upgrade(upgrade)

func _ready() -> void:
	connect("selected_upgrade", Callable(player, "upgrade_character"))
	if item == null:
		item = "food"
	labelName.text = UpgradeDb.UPGRADES[item]["displayname"]
	labelDescription.text = UpgradeDb.UPGRADES[item]["details"]
	labelLevel.text = UpgradeDb.UPGRADES[item]["level"]
	itemIcon.texture = load(UpgradeDb.UPGRADES[item]["icon"])
	
func _input(event: InputEvent) -> void:
	if event.is_action("click"):
		if mouse_over:
			emit_signal("selected_upgrade", item)

func _on_mouse_entered() -> void:
	mouse_over = true

func _on_mouse_exited() -> void:
	mouse_over = false
