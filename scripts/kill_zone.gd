extends Area2D

@onready var timer: Timer = $Timer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
var is_dead = false

func _on_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Player") && timer.time_left == 0) && is_dead != true:
		is_dead = true
		print("You died") # Replace with function body.
		body.die()
		await get_tree().create_timer(0.9).timeout
		audio_stream_player_2d.play()
		timer.start()


func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()

	
