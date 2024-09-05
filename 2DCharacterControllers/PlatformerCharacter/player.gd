extends CharacterBody2D

# SPEED
@export var Speed = 600.0

# DASHING
var Dashing = false
@export var Dash_Speed = 1500.0
# JUMP
var Jumping = false

var jump_count = 0
@export var jump_max = 0

@export var Jump_Height = 2000.0
@export_range(0.0,1.0) var coyoteTime = 0.1

@onready var CayoteTimer = %CayoteTimer
@onready var Fall_Gravity : float = self.get_gravity().y

func _ready():
	CayoteTimer.wait_time = coyoteTime

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += get_state_gravity() * delta
	
	move_and_slide()

func _input(_event):
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if Dashing == false and Input.is_action_just_pressed("Dash"):
		Dashing = true
		%DashTimer.start()
	
	if direction:
		if Dashing:
			velocity.x = direction * Dash_Speed
		else:
			velocity.x = direction * Speed
	else:
		velocity.x = move_toward(velocity.x, 0, Speed)
	
	if is_on_floor():
		jump_count = 0
		Jumping = true
	
	# CAYOTE TIME
	if !is_on_floor() and jump_count < jump_max:
		Jumping = true
		CayoteTimer.start()
	
	# JUMP
	if Jumping and jump_count < jump_max:
		if Input.is_action_just_pressed("ui_accept"):
			Jump()

# JUMP FUNCTION
func Jump():
	velocity.y = -Jump_Height
	jump_count += 1

# GRAVITY FUNCTION
func get_state_gravity(Gravity_speed := 2):
	return get_gravity().y * Gravity_speed if velocity.y < 0.0 else get_gravity().y * Gravity_speed

# CAYOTE TIME TIMER
func _on_cayote_timer_timeout():
	Jumping = false

# DASH TIMER
func _on_dash_timer_timeout() -> void:
	Dashing = false
