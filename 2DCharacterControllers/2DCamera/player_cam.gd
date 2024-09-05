extends Camera2D

var shake_amount = 0
var default_offset = offset
@onready var timer = $Timer

func _ready():
	randomize()
	set_process(false)

func _process(_delta: float) -> void:
	offset = Vector2(randf_range(-1,1) * shake_amount, randf_range(-1,1) * shake_amount)

func shake(amount := 2,time := 0.3):
	timer.wait_time = time
	shake_amount = amount
	set_process(true)
	timer.start()

func _on_timer_timeout() -> void:
	set_process(false)
	var tween = create_tween()
	tween.tween_property(self, "offset", default_offset, 0.5)
