extends Area2D

@onready var timer: Timer = $Timer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player-Knight" && timer.time_left == 0):
		print("You died") # Replace with function body.
		body.die()
		await get_tree().create_timer(1.7).timeout
		audio_stream_player_2d.play()
		timer.start()


func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()

	
