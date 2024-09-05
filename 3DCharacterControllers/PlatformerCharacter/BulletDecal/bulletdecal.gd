extends Node3D

func _on_exist_timer_timeout() -> void:
	var exist_time = 2
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite3D, "modulate", Color(1.0,1.0,1.0,0.0), exist_time).set_trans(Tween.TRANS_SINE)
	await get_tree().create_timer(exist_time).timeout
	queue_free()
