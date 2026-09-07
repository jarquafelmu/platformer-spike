extends CharacterBody2D

@export var speed: float = 3_000.0
@export var jump_velocity: float = -450.0
@export var acceleration: float = 1_000.0
@export var deceleration: float = 2_200.0
@export var fall_limit: float = 800.0

signal collectible_count_changed(new_count: int)

var collectible_count: int = 0
var is_respawning: bool = false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	var direction := Input.get_axis("move_left", "move_right")
	var target_speed := direction * speed
	var rate := acceleration if direction != 0.0 else deceleration
	
	velocity.x =  move_toward(
		velocity.x,
		target_speed,
		rate * delta
	)
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		
	move_and_slide()
	
	if global_position.y > fall_limit:
		reset_player()
		
func reset_player() -> void:
	if is_respawning: 
		return
		
	is_respawning = true
	get_tree().call_deferred("reload_current_scene")
	
func collect_item(value: int) -> void:
	collectible_count += value
	collectible_count_changed.emit(collectible_count)
