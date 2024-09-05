extends Node3D

#   GUN
var can_shoot = true
var current_Weapon = 0
var Ammo = 20
@onready var Muzzle = $WeaponNuzzle
@onready var Guns = $WeaponModels.get_children()
@onready var bulletscene = preload("res://3DCharacterControllers/PlatformerCharacter/Bullet/bullet.tscn")


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			match event.button_index:
				MOUSE_BUTTON_WHEEL_UP:
					current_Weapon += 1
				MOUSE_BUTTON_WHEEL_DOWN:
					current_Weapon -= 1
	
	if can_shoot == true and Input.is_action_just_pressed("Click"):
		shoot()

func _process(_delta: float) -> void:
	global_transform = $"../CameraHolder/NormalViewCam".global_transform
	current_Weapon = clampi(current_Weapon,1,Guns.size())

func shoot():
	var bullet = bulletscene.instantiate()
	bullet.global_transform = Muzzle.global_transform
	bullet.top_level = true
	#bullet.scale = Vector3.ONE
	add_child(bullet)
	Ammo -= 1
	can_shoot = false
	$WeaponDelayTimer.start()

func _on_weapon_delay_timer_timeout() -> void:
	can_shoot = true
