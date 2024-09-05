extends Area3D

@export var speed = 100
@export var damage = 50

func _process(delta: float) -> void:
	position += transform.basis * Vector3(0,0,-speed) * delta
	pass

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("ENEMY"):
		body.health -= damage
		queue_free()
