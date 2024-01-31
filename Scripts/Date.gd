extends Control

@onready var date = get_node("Fond/Date")

var num_date : int

var Num :int:
	get:
		return num_date
	set(value):
		num_date = value
		# print(date)
		date.text = str(num_date)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

