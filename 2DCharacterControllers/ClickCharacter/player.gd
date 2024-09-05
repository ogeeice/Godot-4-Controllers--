extends CharacterBody2D

@export var speed = 300.0
var click_position = Vector2(0,0)

func _ready() -> void:
	click_position = Vector2(position.x,position.y)

func _physics_process(_delta: float) -> void:
	if InputEventMouseButton and Input.is_action_just_pressed("Click"):
		click_position = get_global_mouse_position()
	var target_position = (click_position - position).normalized()
	
	if position.distance_to(click_position) > 3:
		velocity = target_position * speed
		look_at(click_position)
		move_and_slide()
