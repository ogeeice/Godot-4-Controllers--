extends Node3D

var shake_amount = 0
var sensitivity = 0.5

@onready var normal_camera = $CameraHolder
@onready var default_position = normal_camera.position
@onready var screen_shake_timer = $TimerHolder/ScreenShakeTimer


func _ready():
	randomize()
	set_process(false)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		$CameraHolder.rotate_x(deg_to_rad(-event.relative.y * sensitivity))
		$CameraHolder.rotation.x = clamp($CameraHolder.rotation.x, deg_to_rad(-90), deg_to_rad(45))

func _process(_delta: float) -> void:
	normal_camera.position = Vector3(randf_range(-1,1) * shake_amount, randf_range(-1,1) * shake_amount,0)

func shake(amount := 0.2,time := 0.3):
	screen_shake_timer.wait_time = time
	shake_amount = amount
	set_process(true)
	screen_shake_timer.start()

func _on_screen_shake_timer_timeout() -> void:
	set_process(false)
	var tween = create_tween()
	tween.tween_property(normal_camera, "position", default_position, 1)
