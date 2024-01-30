extends Node2D

@onready var date = get_node("Date")

var num_date : int

var Num :int:
	get:
		return num_date
	set(value):
		num_date = value
		date.text = str(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

