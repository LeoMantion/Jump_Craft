extends AudioStreamPlayer2D

func _process(delta):
	while Input.is_action_pressed("right") or Input.is_action_pressed("left"):
		$".".play()
