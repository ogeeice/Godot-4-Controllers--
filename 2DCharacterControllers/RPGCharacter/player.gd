extends CharacterBody2D

var direction = Vector2()
@export var speed = 300.0

func _process(_delta: float) -> void:
	move_and_slide()

func _input(_event: InputEvent) -> void:
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	
	if direction:
		velocity = direction * speed
	else:
		velocity = velocity.move_toward(direction,0)
