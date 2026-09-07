extends CanvasLayer

@onready var collectible_label: Label = $CollectibleLabel
@onready var goal_label: Label = $GoalLabel

func _ready() -> void:
	goal_label.hide()

func _on_player_collectible_count_changed(new_count: int) -> void:
	collectible_label.text = "Collectibles: %d" % new_count

func _on_goal_reached() -> void:
	goal_label.show()
