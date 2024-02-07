extends Node2D

var dict_regle = []
var jour_node_array =[]
var date_node_array =[]


var currentday 
var current_month:int
var current_year:int
# @onready var container = get_node("Box/Grid")


# @onready var container = get_node("Box/Container/Grid")
# @onready var container = get_node("Box/Grid/Container")
@onready var container = get_node("Box/Grid")
@onready var date_node = preload("res://Node/date.tscn")
@onready var date_vide_node = preload("res://Node/dateVide.tscn")
@onready var jour_node = preload("res://Node/Jour.tscn")
var calendrier_class = load("res://Class/Calendrier.gd").new()

# Called when the node enters the scene tree for the first time.

func _ready():
	# jour_node_array.resize(7)
	for d in calendrier_class.jour:
		var new_jour = jour_node.instantiate()
		new_jour.name = d
		jour_node_array.push_back(new_jour)
		container.add_child(new_jour)
	
	for i in 7:
		var jour_en_cour = jour_node_array[i]
		jour_en_cour.set_Jour = calendrier_class.jour[i]
	
	# InstanceDate()
		


func InstanceDate(m,y):
	var nextmonth = current_month<m
	if current_month ==12&&m==1:
		nextmonth = true
	elif current_month ==1 && m==12:
		nextmonth =false
	
	current_month = m
	current_year=y
	for n in date_node_array:
		n.queue_free()
	date_node_array.clear()
	#change for current month
	currentday = calendrier_class.get_beginning_weekday(m,y)
	var totalday = calendrier_class.get_days_in_month(m,y)+currentday
	for i in totalday:
		if i<currentday:
			var new_date = date_vide_node.instantiate()
			new_date.name = "empty"
			date_node_array.push_back(new_date)
			container.add_child(new_date)
		else :
			var new_date = date_node.instantiate()
			new_date.name = str(i-currentday)

			new_date.Jour = i%7
			new_date.Anne = y
			new_date.Mois = m
			date_node_array.push_back(new_date)
			container.add_child(new_date)
	for i in calendrier_class.get_days_in_month(m,y) :
		date_node_array[i+currentday].Date = i+1
	Apply_Regle(nextmonth)

func Regle(m:Dictionary):
	dict_regle.push_back(m)
	Apply_Regle(true)

func Apply_Regle(nm):
	print(nm)
	# var recuringWeekDay 
	for r in dict_regle: 
		if r["recurent"]:
			if !r["date_recurente"]:
				for d in date_node_array.size():
					var node = date_node_array[d]
					if node.is_in_group("date"):
						var dictinit ={
							"year":r["anne"],
							"month":r["mois"],
							"day":r["date"]
						}
						var dictactu ={
							"year":node.Anne,
							"month":node.Mois,
							"day":node.Date
						}
						var tempinit = Time.get_unix_time_from_datetime_dict(dictinit)
						var tempactu = Time.get_unix_time_from_datetime_dict(dictactu)
						var tempdif = (tempactu-tempinit)/86400
						
						if d%7 == r["jour"]&&tempdif%r["jour_recurente"]==0&&tempdif>=0:
							print(tempdif%r["jour_recurente"])
							node.Couleur = r["color"]
			else:
				date_node_array[r["date"]+currentday-1].Couleur = r["color"]
		else:
			var bonmoment = current_month==r["mois"]&&current_year==r["anne"]
			# print(bonmoment)
			# print(str(current_month)+"  "+str(r["mois"])+"  "+str(current_year)+"   "+str(r["anne"]))
			if bonmoment:
				date_node_array[r["date"]+currentday-1].Couleur = r["color"]

		# 	dict_regle.erase(r)



	

