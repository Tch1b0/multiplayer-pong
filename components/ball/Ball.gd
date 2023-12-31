extends CharacterBody2D
class_name Ball

const SPEED = 500.0

func _ready() -> void:
	velocity = Vector2(1, 1) * SPEED

func _process(delta: float) -> void:
	var collision_info := move_and_collide(velocity * delta)
	if collision_info:
		$AudioStreamPlayer.play()
		velocity = velocity.bounce(collision_info.get_normal())
