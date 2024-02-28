extends Control

@export var couleur_select : Color
@onready var date = get_node("Fond/Date")
@onready var fond = get_node("Fond")
@onready var panel = get_node("../../../../../../InfoPanel2")

var calendrier_class = load("res://Class/Calendrier.gd").new()



var num_date : int
var jour_semaine :int
var mois:int
var anne:int

var Couleur : Color:
	set(value):
		fond.color = value

var Jour:int:
	get:
		return jour_semaine
	set(value):
		jour_semaine = value

var Mois:int:
	get:
		return mois
	set(value):
		mois = value

var Anne:int:
	get:
		return anne
	set(value):
		anne = value

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

	# if Input.is_action_pressed("Shift_Left_Mouse_Click"):
	# 	panel.ShiftedClicked(self)
	# 	return
	if Input.is_action_pressed("Left_Mouse_Click")&& self.is_in_group("info_date"):
		fond.color = couleur_select
		panel.on_clicked_date(self)
