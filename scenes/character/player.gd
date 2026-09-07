extends CharacterBody2D

signal collectible_count_changed(new_count: int)
signal died

@export var speed: float = 3_000.0
@export var jump_velocity: float = -450.0
@export var acceleration: float = 1_000.0
@export var deceleration: float = 2_200.0
@export var fall_limit: float = 800.0
@export var drop_through_duration: float = 0.25
@export var drop_velocity: float = 100.0
@export_range(0.0, 1.0, 0.05) var jump_cut_multiplier: float = 0.5

const ONE_WAY_PLATFORM_LAYER: int = 3

var collectible_count: int = 0
var is_respawning: bool = false
var is_dropping_through: bool = false
var air_jump_available: bool = false


func _physics_process(delta: float) -> void:
	var grounded := is_on_floor()
	
	if grounded:
		air_jump_available = true
	else: 
		velocity += get_gravity() * delta
	
	var direction := Input.get_axis("move_left", "move_right")
	var target_speed := direction * speed
	var rate := acceleration if direction != 0.0 else deceleration
	
	velocity.x =  move_toward(
		velocity.x,
		target_speed,
		rate * delta
	)
	
	if Input.is_action_just_pressed("jump"):
		if grounded:
			if Input.is_action_pressed("move_down"):
				drop_through_platform()
			else:
				_perform_jump()
		elif air_jump_available:
			_perform_jump()
			air_jump_available = false
			
	if (
		Input.is_action_just_released("jump")
		and not Input.is_action_pressed("jump")
		and velocity.y < 0.0
	):
		velocity.y *= jump_cut_multiplier
	
	move_and_slide()
	
	if global_position.y > fall_limit:
		die()
	
func _perform_jump() -> void:
	velocity.y = jump_velocity

func die() -> void:
	if is_respawning: 
		return
		
	is_respawning = true
	died.emit()
	
func collect_item(value: int) -> void:
	collectible_count += value
	collectible_count_changed.emit(collectible_count)
	
func drop_through_platform() -> void:
	if is_dropping_through:
		return
	
	is_dropping_through = true
	set_collision_mask_value(ONE_WAY_PLATFORM_LAYER, false)
	velocity.y = drop_velocity
	
	await get_tree().create_timer(drop_through_duration).timeout
	
	set_collision_mask_value(ONE_WAY_PLATFORM_LAYER, true)
	is_dropping_through = false
