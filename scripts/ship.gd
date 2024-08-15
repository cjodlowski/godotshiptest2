extends CharacterBody2D

var SPEED = 400
@onready var bullet_spawn = $"gun"
var bullet = load("res://bullet.tscn")
@onready var timer = $"Timer"
var bullet_TO = true;

@export var max_health : int
@export var curr_health : int : set = emit_health

signal player_death
signal player_health


# Called when the node enters the scene tree for the first time.
func _ready():
	var main = get_node("..")
	player_health.connect(main.on_player_health_update)
	curr_health = max_health 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if(Input.is_action_pressed("shoot") && bullet_TO) :
		timer.start()
		bullet_TO = false;
		#make the bullet
		var instance = bullet.instantiate()
		get_parent().add_child(instance)
		instance.position = bullet_spawn.global_position
		instance.rotation = bullet_spawn.global_rotation
		
	var movement_direction = Input.get_vector("left", "right", "up", "down").normalized()
	if(movement_direction):
		velocity.x = movement_direction.x * SPEED
		velocity.y = movement_direction.y * SPEED
	else :
		velocity.x = lerp(velocity.x, movement_direction.x * SPEED, delta * 8.0)
		velocity.y = lerp(velocity.y, movement_direction.y * SPEED, delta * 8.0)
	
	move_and_slide()
	var collision = get_last_slide_collision()
	if(collision):
		if(collision.get_collider().get_collision_layer() == 2) :
			var dmg = collision.get_collider().damage
			print(dmg)
			take_damage(dmg)
			collision.get_collider().destroy()
		
	
	var rotation_direction = Input.get_vector("r_right", "r_left", "r_up", "r_down").normalized()
	
	if(rotation_direction):
		var rotation_angle = rotation_direction.angle_to(Vector2.UP)
		print(rotation_direction)
		print(rad_to_deg(rotation_angle))
		rotation = rotation_angle

func emit_health(value) :
	curr_health = value
	player_health.emit(value)
	
func take_damage(amt) :
	curr_health = curr_health - amt;
	if(curr_health < 0) :
		die()

func die() :
	player_death.emit()
	
func _on_timer_timeout():
	bullet_TO = true # Replace with function body.
