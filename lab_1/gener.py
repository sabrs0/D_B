from faker import Faker
from random import randint, choice
import datetime
import pandas as pd
import copy

# Пользователи не старше 1900 года страна - США
MALE = 1
FEMALE = 0
CUR_DATE = datetime.datetime.now()
CUR_YEAR = CUR_DATE.year
CORRECT_DATE = datetime.date(CUR_YEAR - 14, CUR_DATE.month, CUR_DATE.day)
fake = Faker()
Users = []



file = open("customers.txt", 'w')
for i in range(1000):
    User = {'User_id' : None, 'Name' : None, 'Location' : None, 'Sex' : None, 'B-day' : None}
    User['User_id'] = i
    User['Location'] = fake.city()
    User['Sex'] = randint(FEMALE, MALE)
    User['B-day'] = str(fake.date_between_dates(datetime.date(1900, 1, 1), CORRECT_DATE))
    if (User['Sex'] == MALE):
        User['Name'] = fake.name_male()
    else:
        User['Name'] = fake.name_female()
    Users.append(User)
    file.write(str(User['User_id']) + '#' + User['Name'] + '#' +User['Location'] + '#' + str(User['Sex']) + '#' + User['B-day'] + '\n')
for i in range(1000):
    for j in range(1000):
        if (Users[i] == Users[j] and i != j):
            print("DISASTER")
file.close()



Drugs = []
prods = pd.read_excel('MOCK_DATA.xlsx', engine='openpyxl')
Brands = [];
Companies = [];
Prices = [];
for i in range (len(prods['Brand'])):
    Brands.append(prods['Brand'][i])
for i in range (len(prods['Company'])):
    Companies.append(prods['Company'][i])
for i in range (len(prods['Price'])):
    Prices.append(prods['Price'][i][1:])

reqs = ['canned', 'dry']
file = open("drugs.txt", 'w')
for i in range(1000):
    Drug = {'Drug_id' : None, 'Name' : None, 'Company' : None, 'Price' : None, 'Made_in_country' : None, 'Transport_reqs' : None, 'Expiration_date' : None}
    Drug['Drug_id'] = i
    Drug['Name'] = Brands[i]
    Drug['Company'] = Companies[i]
    Drug['Price'] = Prices[i]
    Drug['Made_in_country'] = fake.country()
    Drug['Transport_reqs'] = choice(['canned', 'dry'])
    Drug['Expiration_date'] = str(fake.date_between_dates(datetime.date(2022, 1, 1), datetime.date(2040, 1, 1)))
    Drugs.append(Drug)
    file.write(str(Drug['Drug_id']) + '#' + Drug['Name'] + '#' + Drug['Company'] + '#' + Drug['Price'] + '#' + Drug['Made_in_country'] + '#' + Drug['Transport_reqs'] + '#' + Drug['Expiration_date'] + '\n')
for i in range(1000):
    for j in range(1000):
        if (Drugs[i] == Drugs[j] and i != j):
            print("DISASTER")
file.close()

Routes = []
kars = pd.read_excel('KARS.xlsx', engine='openpyxl')
cars = [];
planes = ["Antonov An-225 Mriya. Ralf Manteufel",
    "Boeing 747 Dreamlifter. Getty Images",
    "Aero Spacelines Super Guppy. Getty Images",
    "Antonov An-124 Condor",
    "Lockheed C-5 Galaxy",
    "Airbus A300-600ST Beluga",
    "Antonov An-22 Antei",
    "Boeing C-17 Globemaster III"]
for i in range (len(kars['Model'])):
    cars.append(kars['Car'][i] + ' ' + kars['Model'][i])

file = open("routes.txt", 'w')
for i in range(1000):
    Route = {'Route_id' : None, 'From' : None, 'To' : None, 'Transport' : None, 'Transport_type' : None, 'Med_fridge' : None, 'Hours' : None}
    Route['Route_id'] = i
    Route['From'] = fake.city(); Route['To'] = fake.city();
    while (Route['From'] == Route['To']):
        Route['From'] = fake.city(); Route['To'] = fake.city();
    Route['Transport_type'] = choice(['air', 'road'])
    if Route['Transport_type'] == 'air':
        Route['Transport'] = choice(planes)
    else:
        Route['Transport'] = choice(cars)
    if Drugs[i]['Transport_reqs'] == 'canned':
        Route['Med_fridge'] = 1
    else:
        Route['Med_fridge'] = 0
    # высчитал , за сколько америку поперек можно проехать если ехать 60 
    Route['Hours'] = randint(3, 85)
    Routes.append(Route)
    file.write(str(Route['Route_id']) + '#' + Route['From'] + '#' + Route['To'] + '#' + Route['Transport'] + '#' + Route['Transport_type']  + '#' + str(Route['Med_fridge'])  + '#' + str(Route['Hours'])  + '\n')
for i in range(1000):
    for j in range(1000):
        if (Routes[i] == Routes[j] and i != j):
            print("DISASTER")
file.close()

C_Users = copy.deepcopy(Users)
C_Drugs = copy.deepcopy(Drugs)
C_Routes = copy.deepcopy(Routes)
Deliveries = []
file = open("deliveries.txt", 'w')
for i in range(1000):
    Deliv = {'Delivery_id' : None, 'User_id' : None, 'Drug_id' : None, 'Route_id' : None, 'Product_amount' : None}
    Deliv['Delivery_id'] = i 
    Deliv['User_id'] = C_Users.pop(C_Users.index(choice(C_Users)))['User_id']
    Deliv['Drug_id'] = C_Drugs.pop(C_Drugs.index(choice(C_Drugs)))['Drug_id']
    if (Drugs[Deliv['Drug_id']]['Transport_reqs'] == 'canned'):
        for i in C_Routes:
            if i['Med_fridge'] == 1:
                Deliv['Route_id'] = C_Routes.pop(C_Routes.index(i))['Route_id']
                break;
    else:
        for i in C_Routes:
            if i['Med_fridge'] == 0:
                Deliv['Route_id'] = C_Routes.pop(C_Routes.index(i))['Route_id']
                break;
    Deliv['Product_amount'] = randint(1,20)
    Deliveries.append(Deliv)
    file.write(str(Deliv['Delivery_id']) + '#' + str(Deliv['User_id']) + '#' + str(Deliv['Drug_id']) + '#' + str(Deliv['Route_id']) + '#' + str(Deliv['Product_amount']) + '\n')
file.close()










