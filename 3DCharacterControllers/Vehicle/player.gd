extends VehicleBody3D

@export var auto_drive = false
@export var max_steer = 0.9
@export var accel_speed = 10
@export var engine_power = 300

func _physics_process(delta: float) -> void:
	steering = move_toward(steering, Input.get_axis("ui_right", "ui_left") * max_steer,delta * accel_speed)
	
	if auto_drive:
		engine_force = 1 * engine_power
	else:
		engine_force = Input.get_axis("ui_down", "ui_up") * engine_power
