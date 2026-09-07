extends Node2D

var is_restarting: bool = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		restart_level()
		
func restart_level() -> void:
	if is_restarting:
		return
		
	is_restarting = true
	get_tree().call_deferred("reload_current_scene")
	
func _on_hud_restart_requested() -> void:
	restart_level()
