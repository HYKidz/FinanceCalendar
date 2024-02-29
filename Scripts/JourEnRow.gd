extends Node2D

var calendrier_class = load("res://Class/Calendrier.gd").new()

var dict_regle = []
var jour_node_array =[]
var date_node_array =[]

var list_de_node: Array:
	get:
		return date_node_array


var currentday 
var current_month:int
var current_year:int

@onready var container = get_node("Box/Grid")
@onready var date_node = preload("res://Node/date.tscn")
@onready var date_vide_node = preload("res://Node/dateVide.tscn")
@onready var jour_node = preload("res://Node/Jour.tscn")

# Called when the node enters the scene tree for the first time.

func _ready():
	for d in calendrier_class.jour.size():
		var new_jour = jour_node.instantiate()
		new_jour.init()
		new_jour.name = calendrier_class.jour[d]
		new_jour.set_Jour = d
		jour_node_array.push_back(new_jour)
		container.add_child(new_jour)

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
	var dict = m.duplicate(true)
	dict_regle.push_back(dict)
	Apply_Regle(true)

func Apply_Regle(_r):
	for r in dict_regle: 
		if current_month>=r["starting_mois"]&&current_year>=r["starting_anne"]:
			print(r["date"])
			if r["recurent"]:
				if !r["date_recurente"]:
					#Refactor, cause cant make work of two jour
					for d in date_node_array.size():
						var node = date_node_array[d]
						if node.is_in_group("date"):
							var dictinit ={
								"year":r["starting_anne"],
								"month":r["starting_mois"],
								"day":r["starting_jour"]
							}
							var dictactu ={
								"year":node.Anne,
								"month":node.Mois,
								"day":node.Date
							}
							var tempinit = Time.get_unix_time_from_datetime_dict(dictinit)
							var tempactu = Time.get_unix_time_from_datetime_dict(dictactu)
							var tempdif = (tempactu-tempinit)/86400
							#ne regle pas le probleme mais l'empeiche, pas suposse de se rendre ici si on met une date recurente
							if r["jour"].size()>0&&d%7 ==r["jour"][0]&&tempdif%r["jour_recurente"]==0&&tempdif>=0:
								print(tempdif%r["jour_recurente"])
								node.Couleur = r["color"]
						#***
				else:
					for d in r["date"]:
						date_node_array[d["date"]+currentday-1].Couleur = r["color"]
			else:
				for d in r["date"]:
					var bonmoment = current_month==d["mois"]&&current_year==d["anne"]
					if bonmoment:
						date_node_array[d["date"]+currentday-1].Couleur = r["color"]



	

