extends CharacterBody2D

@export var speed: float = 3_000.0
@export var jump_velocity: float = -450.0
@export var acceleration: float = 1_000.0
@export var deceleration: float = 2_200.0
@export var fall_limit: float = 800.0

var spawn_position: Vector2
var collectible_count: int = 0

func _ready() -> void:
	spawn_position = global_position

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
	global_position = spawn_position
	velocity = Vector2.ZERO
	
func collect_item(value: int) -> void:
	collectible_count += value
	print("Collectibles: ", collectible_count)
