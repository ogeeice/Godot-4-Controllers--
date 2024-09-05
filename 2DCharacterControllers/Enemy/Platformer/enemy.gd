extends CharacterBody2D

@export var FacingL = true
@export var speed = 300.0

func _process(delta: float) -> void:
	velocity += get_gravity() * delta
	if %WallDetect.is_colliding() || !%FloorDetect.is_colliding():
		Flip()
	
	velocity.x = speed
	move_and_slide()

func Flip():
	FacingL = !FacingL
	
	if FacingL:
		speed = abs(speed)
		$RaycastHolder.scale.x = 1
	else:
		speed = abs(speed) * -1
		$RaycastHolder.scale.x = -1
