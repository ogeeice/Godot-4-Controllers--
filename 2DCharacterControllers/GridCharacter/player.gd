extends CharacterBody2D

@export var speed = 64

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_up"):
		position.y -= speed
	elif Input.is_action_just_pressed("ui_down"):
		position.y += speed
	
	if Input.is_action_just_pressed("ui_left"):
		position.x -= speed
	elif Input.is_action_just_pressed("ui_right"):
		position.x += speed
