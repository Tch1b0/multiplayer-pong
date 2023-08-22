extends Node2D
class_name Game

enum PlayerNum {
	ONE,
	TWO
}

var ball_scene := preload("res://components/ball/Ball.tscn")
var scores := {
	PlayerNum.ONE: 0,
	PlayerNum.TWO: 0,
}

@onready var available_positions = [$Player1Position.position, $Player2Position.position]

func _on_child_entered_tree(node: Node) -> void:
	if node.is_in_group("Player"):
		node.position = available_positions.pop_front()
		if len(available_positions) == 0:
			spawn_ball()

func spawn_ball() -> void:
	var ball := ball_scene.instantiate()
	ball.position = $BallPosition.position
	add_child(ball)

func goal(player: PlayerNum):
	scores[player] += 1
	$PlayerOnePoints.text = str(scores[PlayerNum.ONE])
	$PlayerTwoPoints.text = str(scores[PlayerNum.TWO])
	await get_tree().create_timer(3).timeout
	spawn_ball()


func handle_goal(body: Node2D, player: PlayerNum) -> void:
	if not body.is_in_group("Ball"):
		return
	var particles := $GPUParticles2D
	particles.position = body.position
	particles.rotation_degrees = 0 if player == PlayerNum.TWO else 180
	goal(player)
	particles.emitting = true
	if bool(randi_range(0, 1)):
		$EffectPlayer1.play()
	else:
		$EffectPlayer2.play()
	body.queue_free()

func _on_goal_left_body_entered(body: Node2D) -> void:
	handle_goal(body, PlayerNum.TWO)

func _on_goal_right_body_entered(body: Node2D) -> void:
	handle_goal(body, PlayerNum.ONE)
