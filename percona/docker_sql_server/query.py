import random
import time
import os
import MySQLdb

first_names = [line.strip() for line in open('/var/lib/mysql-files/firstnames.txt')]
last_names = [line.strip() for line in open('/var/lib/mysql-files/lastnames.txt')]
countries = [line.strip() for line in open('/var/lib/mysql-files/countries.txt')]
emails = [line.strip() for line in open('/var/lib/mysql-files/emails.txt')]

statements = ['select','insert']
database = 'test'
table = 'Users'
columns = ['First_Name','Last_Name','Email','Country','Birth','Joined','Comment']

def getRandomDate(start, end, rand):
    format = '%d/%m/%y'
    stime = time.mktime(time.strptime(start, format))
    etime = time.mktime(time.strptime(end, format))

    ptime = stime + rand*(etime - stime)

    return time.strftime(format, time.localtime(ptime))

def getRandomBirth():
    return getRandomDate('31/12/75','01/01/05',random.random())

def getRandomJoined():
    return getRandomDate('01/01/10','12/07/17',random.random())

def getRandomFirstName():
    return random.choice(first_names)

def getRandomLastName():
    return random.choice(last_names)

def getRandomEmail():
    return random.choice(emails)

def getRandomCountry():
    return random.choice(countries)

def getRandomComment():
    return 'This is a comment'

rand_functions = { 0: getRandomFirstName,
                   1: getRandomLastName,
                   2: getRandomEmail,
                   3: getRandomCountry,
                   4: getRandomBirth,
                   5: getRandomJoined,
                   6: getRandomComment
}

def getRandomQuery():
    statement_type = random.randint(0,len(statements)-1)
    if statement_type == 0:
        query = "select "
        sample = random.sample(columns,random.randint(1,len(columns)))
        query += ", ".join(sample) + " from " + database + "." + table
        if random.randint(0,1):
            col = random.randint(0,len(columns)-2) 
            query += " where " + columns[col] + " = '" + rand_functions[col]() + "';"
    elif statement_type == 1:
        query = "insert into " + database + "." + table + " ("
        query += ", ".join(columns) + ")"
        query += " values ('"
        values = []
        for i,val in enumerate(columns):
            values.append(rand_functions[i]())
        query += "', '".join(values) + "');"
    print 'query: ' + query
    return query

db = MySQLdb.connect(read_default_file='/root/.my.cnf')
cur = db.cursor()
cur.execute(getRandomQuery())
for row in cur.fetchall():
    print row[0]
print "Auto Increment ID: %s" % cur.lastrowid
db.commit()
db.close()
