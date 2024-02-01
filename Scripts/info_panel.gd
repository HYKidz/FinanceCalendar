extends Control

var calendrier_class = load("res://Class/Calendrier.gd").new()

var depense_b : bool
var revenue_b : bool
var fix_b : bool
var salarial_b : bool
var recurent_b : bool
var date_b:bool

var date:int
var jour:int
var mois:int
var anne:int

var montant:int
var heure:int

@export var group: ButtonGroup 
@onready var date_label = get_node("Contour/Fond/Date") 
@onready var rev_option = get_node("RevenuOption") 
@onready var salarial_option = get_node("RevenuOption/SalarialOption") 
@onready var recurent_option = get_node("Contour/Fond/Option/Recuring") 
@onready var couleur = get_node("Color")
@onready var calendar = get_node("../JourEnRow")
@onready var description = get_node("Description/Description")
# @onready var montant_edit = get_node("ZoneMontant/Montant") 

#keep in mind when you need to use signals

# func _ready():
# 	for i in group.get_buttons():
# 		i.pressed.connect(button_pressed)

# func button_pressed():
# 	print(group.get_pressed_button())
	
func _on_clicked_date(d,j,m,y):
	date = d
	jour = j
	mois = m
	anne =y
	date_label.text = calendrier_class.jour[j]+"    "+str(d)

func _on_recurent_toggled(button_pressed):
	recurent_b = button_pressed
	recurent_option.visible = button_pressed

func _on_montant_value_changed(value):
		montant = value
		

func _on_heure_value_changed(value):
	heure = value

func _on_date_toggled(button_pressed:bool):
	date_b = button_pressed
	


#Gestion Revenu

func _on_revenu_toggled(button_pressed):
	revenue_b = button_pressed
	rev_option.visible=button_pressed


func _on_fixe_toggled(button_pressed):
	fix_b = button_pressed
	pass # Replace with function body.


func _on_salarial_toggled(button_pressed):
	salarial_b = button_pressed
	salarial_option.visible = button_pressed

	pass # Replace with function body.


#GestionDepense

func _on_depense_toggled(button_pressed):
	depense_b = button_pressed




func _on_button_pressed():
	var m ={
		"depense":depense_b,
		"recurent":recurent_b,
		"salarial":salarial_b,
		"montant": montant,
		"heure": heure,
		"date_recurente":date_b,
		"date":date,
		"jour":jour,
		"mois":mois,
		"anne":anne,
		"description":description.text,
		"color": couleur.color
		
	}
	# print(calendar)
	calendar.Regle(m)




