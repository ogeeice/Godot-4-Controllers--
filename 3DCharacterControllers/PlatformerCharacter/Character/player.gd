extends CharacterBody3D

@export var Speed = 10 ## Charcter movement speed

# JUMP
var canJump = false
var jump_count = 0

@export var NewJump = false
@export var jump_max = 2

@export var Jump_Height = 10 ## Character jump force
@export var Jump_Time_peak = 0.005 ## Time it takes for character to reach jump peak, should be between 0.005 - 0.01 
@export var Jump_Time_Descend = 1.0 ## Time it takes for chracter to descend from a fall
@export_range(0.0,1.0) var coyoteTime = 0.1 ## Extra time character has to jump when falling off a platform

@onready var CayoteTimer = $CameraPivot/TimerHolder/Cayote_Timer
@onready var Jump_Velocity : float = (2.0 * Jump_Height) / Jump_Time_Descend
@onready var Jump_Gravity : float = (-2.0 * Jump_Height) / (Jump_Time_Descend * Jump_Time_Descend)
@onready var Fall_Gravity : float = (-2.0 * Jump_Height) / (Jump_Time_Descend * Jump_Time_Descend)

@onready var CamPivot = $CameraPivot

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		if NewJump == true:
			velocity.y = get_state_gravity() * delta
		else:
			velocity = get_gravity() * delta
	
	move_and_slide()

func _process(_delta: float) -> void:
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (CamPivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * Speed
		velocity.z = direction.z * Speed
		$MeshInstance3D.rotation.y = lerp($MeshInstance3D.rotation.y,atan2(-velocity.x,-velocity.z),0.5)
	else:
		velocity.x = move_toward(velocity.x, 0, Speed)
		velocity.z = move_toward(velocity.z, 0, Speed)
	
	if is_on_floor():
		jump_count = 0
		canJump = true
	
	if !is_on_floor() and jump_count < jump_max:
		canJump = true
		CayoteTimer.start()
	
	if canJump and jump_count < jump_max:
		if Input.is_action_just_pressed("ui_accept"):
			Jump()

func Jump():
	if NewJump == true:
		velocity.y = Jump_Height
	else:
		velocity.y = Jump_Height
	jump_count += 1

func get_state_gravity():
	return Jump_Gravity if velocity.y < 0.0 else Fall_Gravity

func _on_cayote_timer_timeout() -> void:
	canJump = false
	print("DONE")
