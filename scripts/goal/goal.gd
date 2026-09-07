extends Area2D

signal reached

var activated: bool = false

func _on_body_entered(body: Node2D) -> void:
	if activated or not body.is_in_group("player"):
		return
		
	activated = true
	reached.emit()
	set_deferred("monitoring", false)
