extends CanvasLayer

@onready var collectible_label: Label = $CollectibleLabel

func _on_player_collectible_count_changed(new_count: int) -> void:
	collectible_label.text = "Collectibles: %d" % new_count
