extends Control

var calendrier_class = load("res://Class/Calendrier.gd").new()

var depense_b : bool = true
var revenue_b : bool
var fix_b : bool
var salarial_b : bool
var recurent_b : bool
var date_b:bool

var jour_recurent:int
var date_node_array =[]
var jour_node_array =[]

var montant:int
var heure:int
var mois:int
var anne:int

@export var group: ButtonGroup 
@onready var date_label = get_node("Contour/Fond/Date") 
@onready var jour_label = get_node("Contour/Fond/Option/Recuring/NbJour") 
@onready var recuring = get_node("Contour/Fond/Option/Recuring")
@onready var jour_toggle = get_node("Contour/Fond/Option/Jour")
@onready var send_button = get_node("Send")
@export var jour_option : Node
# @export var date_option : Node
@onready var date_option = get_node("Contour/Fond/Selection/Date")
@onready var starting_jour_button = get_node("Contour/Fond/Selection/Jour/JourDebut")
@onready var starting_jour : int
# @onready var jour_option = get_node("Contour/Fond/Selection/Date")
@export var rev_option : Node
@export var salarial_option : Node
@export var recurent_option : Node
# @onready var rev_option = get_node("RevenuOption") 
# @onready var salarial_option = get_node("RevenuOption/SalarialOption") 
# @onready var recurent_option = get_node("Contour/Fond/Option/Recuring") 
@onready var couleur = get_node("Color")
@onready var jourEnRow = get_node("../JourEnRow")
@onready var calendar = get_node("../../Calendar")
@onready var description = get_node("Description/Description")
@onready var date_node = preload("res://Node/date.tscn")
@onready var date_vide_node = preload("res://Node/dateVide.tscn")
# @onready var container = get_node("Contour/Fond/Date/Fond/Date")
# @onready var montant_edit = get_node("ZoneMontant/Montant") 
var date_clicked = []
var jour_clicked = []
#keep in mind when you need to use signals

func Init(m,y):
	# print(date_option.name)
	mois =m
	anne =y
	date_node_array = date_option.get_children()
	var totalday = calendrier_class.get_days_in_month(m,y)
	var nb_child_date = date_option.get_child_count()
	for i in nb_child_date:

		date_node_array[i].add_to_group("info_date")
		date_node_array[i].visible = true
		date_node_array[i].Date = i+1
		date_node_array[i].Mois = m
		date_node_array[i].Anne = y
		if i+1 >totalday:
			date_node_array[i].visible = false
	
	jour_node_array = jour_option.get_children()
	# var nb_child_jour = jour_node_array.size()
	for i in 7:
		jour_node_array[i].add_to_group("info_jour")
		jour_node_array[i].set_Jour = i
		pass
		
# 	for i in group.get_buttons():
# 		i.pressed.connect(button_pressed)

# func button_pressed():
# 	print(group.get_pressed_button())
	
func Current_Month(m,y):
	killAndClear()
	mois =m
	anne =y
	var totalday = calendrier_class.get_days_in_month(m,y)
	var nb_child = date_option.get_child_count()
	for i in nb_child:
		date_node_array[i].visible = true
		date_node_array[i].Date = i+1
		date_node_array[i].Mois = m
		date_node_array[i].Anne = y
		if i+1 >totalday:
			date_node_array[i].visible = false
	# for n in date_node_array:
	# 	n.queue_free()
	# date_node_array.clear()
	# #change for current month
	# var currentday = calendrier_class.get_beginning_weekday(m,y)
	# var totalday = calendrier_class.get_days_in_month(m,y)+currentday
	# for i in totalday:
	# 	if i<currentday:
	# 		var new_date = date_vide_node.instantiate()
	# 		new_date.name = "empty"
	# 		date_node_array.push_back(new_date)
	# 		container.add_child(new_date)
	# 	else :
	# 		var new_date = date_node.instantiate()
	# 		new_date.name = str(i-currentday)

	# 		new_date.Jour = i%7
	# 		new_date.Anne = y
	# 		new_date.Mois = m
	# 		date_node_array.push_back(new_date)
	# 		container.add_child(new_date)
	# for i in calendrier_class.get_days_in_month(m,y) :
	# 	date_node_array[i+currentday].Date = i+1

func _on_recurent_toggled(button_pressed):
	recurent_b = button_pressed
	recuring.visible = button_pressed
	recurent_option.visible = button_pressed
	jour_toggle.visible = button_pressed

func _on_montant_value_changed(value):
		montant = value
		

func _on_heure_value_changed(value):
	heure = value

func _on_date_toggled(button_pressed:bool):
	killAndClear()
	date_b = button_pressed
	date_option.visible = button_pressed

func _on_jour_toggled(button_pressed):
	killAndClear()
	# recuring_jour = button_pressed
	jour_option.visible = button_pressed
	jour_label.visible = button_pressed

func _on_jour_value_changed(value):
	jour_recurent = value
	

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

func on_clicked_jour(jour):
	if jour_clicked.has(jour):
		jour.Couleur = Color(1,1,1)
		jour_clicked.erase(jour)
		return
	jour_clicked.push_back(jour)
	# starting_jour.visible = true
	# print(jour)
	if jour_clicked.size()>0:
		send_button.visible = true
		starting_jour_button.visible = true
	ajout_option()


func on_clicked_date(date):
	if date_clicked.has(date):
		date.Couleur = Color(1,1,1)
		date_clicked.erase(date)
		return
	date_clicked.push_back(date)
	# print(date)
	if date_clicked.size()>0:
		send_button.visible = true


func ajout_option():
	var begining = calendrier_class.get_beginning_weekday(mois,anne)
	var total = calendrier_class.get_days_in_month(mois,anne)
	for i in total:
		var e = i+begining
		# print(e)
		# print(calendrier_class.jour[e])
		# print(i+begining%7)
		# print(i+begining-1%7)
		if e%7==jour_clicked[0].set_Jour:
			print(e-begining+1)
			starting_jour_button.add_item(str(e-begining+1))
		# 	print("hello")
		
func _on_jour_debut_item_selected(index):
	# starting_jour_button.label[index]
	print(starting_jour_button.get_item_text(index))
	# var current_selected = index


func _on_button_pressed():
	var id = starting_jour_button.get_selected_id()
	if jour_recurent ==0:
		jour_recurent=1
	var m ={
		"depense":depense_b,
		"recurent":recurent_b,
		"salarial":salarial_b,
		"montant": montant,
		"heure": heure,
		"date_recurente":date_b,
		"jour_recurente":jour_recurent, 
		"jour_recurente_actuel":jour_recurent, 
		"date":date_clicked,
		"jour":jour_clicked,
		"starting_jour":starting_jour_button.get_item_text(id),
		"starting_mois":mois,
		"starting_anne":anne,
		"description":description.text,
		"color": couleur.color
		
	}
	jourEnRow.Regle(m)
	calendar.calculate_cash(m)
	# print(date_b)
	# killAndClear()

func killAndClear():
	# depense_b = false
	# recurent_b = false
	# salarial_b = false
	# date_b = false
	for date in date_clicked:
		date.Couleur = Color(1,1,1,1)
	date_clicked.clear()
	for jour in jour_clicked:
		jour.Couleur = Color(1,1,1,1)
	jour_clicked.clear()














