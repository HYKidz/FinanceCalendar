extends Control

@onready var jour = get_node("Jour")

var current_jour : String
var set_Jour : String :
	set(value):
		current_jour = value
		jour.text = value
		
		# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
