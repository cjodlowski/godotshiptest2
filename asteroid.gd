extends StaticBody2D

@onready var explode_particles = $death_particles
@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D

@export var damage : int

signal obstacle_destroyed

# Called when the node enters the scene tree for the first time.
func _ready():
	var main = get_node("..")
	obstacle_destroyed.connect(main.on_obstacle_destroyed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func destroy():
	sprite.visible = false;
	collision.disabled = true;
	explode_particles.restart()
	
func explode():
	obstacle_destroyed.emit(1)
	destroy()

func _on_gpu_particles_2d_finished():
	queue_free()
