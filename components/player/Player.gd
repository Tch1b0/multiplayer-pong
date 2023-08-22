extends CharacterBody2D
class_name Player

@export var speed: float = 400


func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _physics_process(_delta: float) -> void:
	if is_multiplayer_authority():
		if Input.is_action_pressed("ui_up"):
			velocity.y = -speed 
		elif Input.is_action_pressed("ui_down"):
			velocity.y = speed
		else:
			velocity.y /= 2
	
	velocity.x = 0
	move_and_slide()
