extends Area2D




func _on_body_entered(body: Node2D) -> void:
		var y_delta = position.y - body.position.y
		print(y_delta)
		
