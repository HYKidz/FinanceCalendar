extends Control

@onready var date = get_node("Fond/Date")
@onready var calendar = get_node("../../../../../Calendar")
var calendrier_class = load("res://Class/Calendrier.gd").new()

var num_date : int
var jour_semaine :int

var Jour:int:
	get:
		return jour_semaine
	set(value):
		jour_semaine = value


var Date :int:
	get:
		return num_date
	set(value):
		num_date = value
		# print(date)
		date.text = str(num_date)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_fond_gui_input(_event):

	if Input.is_action_pressed("Shift_Left_Mouse_Click"):
		calendar.ShiftedClicked(self)
		return
	if Input.is_action_pressed("Left_Mouse_Click"):
		calendar.Clicked(self)
