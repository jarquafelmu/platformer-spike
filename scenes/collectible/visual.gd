extends Node2D

@export var radius: float = 12.0
@export var color: Color = Color.GOLD

func _draw() -> void:
	draw_circle(Vector2.ZERO, radius, color)
