extends CharacterBody2D
class_name Player

@export var speed: float = 200


func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _physics_process(delta: float) -> void:
	if is_multiplayer_authority():
		if Input.is_action_pressed("ui_up"):
			velocity.y = max(velocity.y - delta * speed, -200) 
		elif Input.is_action_pressed("ui_down"):
			velocity.y = min(velocity.y + delta * speed, 200)
		else:
			velocity.y /= 2
	
	velocity.x = 0
	move_and_slide()
