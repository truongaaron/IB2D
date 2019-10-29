extends Area2D

var startPosition = Vector2()

func _ready():
	startPosition.x = position.x
	startPosition.y = position.y

func _process(delta):
	pass

func _on_Area2D_body_entered(body):
	if body.name == "Potato":
		startPosition.x = position.x
		startPosition.y = position.y
		print(startPosition)
