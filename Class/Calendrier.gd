class_name Calendrier

enum Month {JAN=1, FEB=2, MAR=3, APR=4, MAY=5, JUN=6, JUL=7, AUG=8, SEP=9, OCT=10, NOV=11, DEC=12}

var mois = ["Janvier","Fevrier","Mars","Avril","Mai","Juin","Juillet","Aout","Septembre","Octobre","Novembre","Decembre"]
var jour = ["Dimanche","Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi"]

func get_days_in_month(month : int, year : int):

	var number_of_days : int

	if(month == Month.APR || month == Month.JUN|| month == Month.SEP|| month == Month.NOV):
		number_of_days=30

	elif(month == Month.FEB):
		var is_leap_year = (year % 4 == 0 &&year% 100 !=0) || (year%400 ==0)

		if(is_leap_year):
			number_of_days = 29

		else:
			number_of_days = 28

	else:
		number_of_days = 31

	return number_of_days

func get_beginning_weekday(m:int, y, d=1):
	var t = [0,3,2,5,0,3,5,1,4,6,2,4]
	if m <3 : y-= 1
	return(y + y/4 - y/100 + y/400 + t[m-1] + d) % 7
