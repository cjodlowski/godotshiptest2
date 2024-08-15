extends Node2D

var score = 0
var health = 0
@onready var score_label = $RichTextLabel
@onready var health_label = $RichTextLabel2

# Called when the node enters the scene tree for the first time.
func _ready():
	health_label.text = "HEALTH: " + str(health)
	score_label.text = "SCORE: " + str(score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_obstacle_destroyed(points) :
	score = score + points
	score_label.text = "SCORE: " + str(score)
	print(score)
	
func on_player_health_update(h) :
	health = h
	if(health_label) :
		health_label.text = "HEALTH: " + str(health)
	
