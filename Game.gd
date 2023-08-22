extends Node2D
class_name Game

var ball_scene := preload("res://Ball.tscn")

@onready var available_positions = [$Player1Position.position, $Player2Position.position]

@rpc("call_remote")
func _on_child_entered_tree(node: Node) -> void:
	if node.is_in_group("Player"):
		print("HRER")
		node.position = available_positions.pop_front()
		if len(available_positions) == 0:
			var ball := ball_scene.instantiate()
			ball.position = $BallPosition.position
			add_child(ball)
