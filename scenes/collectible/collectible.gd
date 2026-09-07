extends Area2D


@export var value: int = 1

func _on_body_entered(body: Node2D) -> void:
	if not body.has_method("collect_item"):
		return
		
	body.call("collect_item", value)
	queue_free()
