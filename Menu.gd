extends Control
class_name Menu

var player_scene := preload("res://Player.tscn")

@onready var game: Game = $Game

func _on_host_button_pressed() -> void:
	Networking.is_host = true
	Networking.peer.create_server(Networking.PORT)
	multiplayer.multiplayer_peer = Networking.peer
	multiplayer.peer_connected.connect(_spawn_player)
	$Title.hide()
	$VBoxContainer.hide()
	$Game.show()
	_spawn_player()

func _spawn_player(id = 1) -> void:
	var player = player_scene.instantiate()
	player.name = str(id)
	$Game.call_deferred("add_child", player)

func _on_join_button_pressed() -> void:
	Networking.peer.create_client(%HostIPTextEdit.text, Networking.PORT)
	multiplayer.multiplayer_peer = Networking.peer
