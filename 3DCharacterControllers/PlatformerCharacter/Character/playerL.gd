extends CharacterBody3D

@export var Speed = 10

# DASHING
var Dashing = false
@export var Dashing_Speed = 50

@export var Gravity = 50.0
@export var GravityJ = 100.0

# JUMP
var Jumping = false
var jump_count = 0
@export var jump_max = 2
@export var Jump_Height = 30
@onready var CayoteTimer = %CayoteTimer
@export_range(0.0,2.0) var coyoteTime = 1.5

@onready var CamPivot = $CameraPivot

func _ready() -> void:
	CayoteTimer.wait_time = coyoteTime

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y -= get_state_gravity() * delta
	move_and_slide()

func _process(_delta: float) -> void:
	Movement()

func Movement() -> void:
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (CamPivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# DASHING
	if Dashing == false and Input.is_action_just_pressed("Dash"):
		Dashing = true
		%DashTimer.start()
	
	if direction:
		if Dashing:
			velocity.x = direction.x * Dashing_Speed
			velocity.z = direction.z * Dashing_Speed
		else:
			velocity.x = direction.x * Speed
			velocity.z = direction.z * Speed
		$MeshInstance3D.rotation.y = lerp($MeshInstance3D.rotation.y,atan2(-velocity.x,-velocity.z),0.5)
	else:
		velocity.x = move_toward(velocity.x, 0, Speed)
		velocity.z = move_toward(velocity.z, 0, Speed)
	
	if is_on_floor():
		jump_count = 0
		Jumping = true
	
	if !is_on_floor() and jump_count < jump_max:
		Jumping = true
		CayoteTimer.start()
	
	if Jumping and jump_count < jump_max:
		if Input.is_action_just_pressed("ui_accept"):
			Jump()

# JUMP FUNCTION
func Jump():
	velocity.y = Jump_Height
	jump_count += 1

# GRAVITY FUNCTION
func get_state_gravity(Gravity_speed := 2):
	return GravityJ * Gravity_speed if velocity.y < 0.0 else Gravity * Gravity_speed

# CAYOTE TIME TIMER
func _on_cayote_timer_timeout() -> void:
	Jumping = false

# DASH TIMER
func _on_dash_timer_timeout() -> void:
	Dashing = false
