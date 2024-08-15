extends Node2D

var SPEED = 200
@onready var raycast =  $RayCast2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.x * SPEED * delta
	if(raycast.is_colliding()) :
		raycast.get_collider().explode()
		queue_free()


func _on_timer_timeout():
	queue_free()# Replace with function body.

