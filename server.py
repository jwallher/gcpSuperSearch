#import MySQLdb, utils
import os
import psycopg2
import psycopg2.extras
import sys
reload(sys)
sys.setdefaultencoding("UTF8")

from flask import Flask, render_template, request, redirect, url_for, session


app = Flask(__name__)

app.secret_key = os.urandom(24).encode('hex')

#session['currentUser'] = ''

def connectToDB():
    connectionString = 'dbname=sessions user=postgres password=password host=localhost'
    print connectionString
    try:
        return psycopg2.connect(connectionString)
    except:
        print("cannont connect to DB")


@app.route('/', methods=['GET', 'POST'])
def mainIndex():
    conn = connectToDB()
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    
    if('currentUser' in session):
        curUser=session['currentUser']
    else:
        curUser=''
    
    if('zip' in session):
        curZip = session['zip']
    else:
        curZip='%'
        
    print "mainIndex"
    queryType = 'None'
    print('User: ' + curUser)
    rows = []
    # if user typed in a post ...
    if request.method == 'POST':
      print "post"
      searchTerm = request.form['search']
      if '\'' in searchTerm:
         print "apostrophy"
         idex=searchTerm.index('\'') 
         searchTerm = searchTerm[:idex] + '\'' + searchTerm[idex:]
         print searchTerm
      if(searchTerm=='stores'):
          query="SELECT * from stores where Cast(zip as text)  LIKE '%s';"%str(curZip)
          queryType='stores'
          query=cur.mogrify(query);
          print(query)
      elif(searchTerm=='movies'):
          query=("SELECT * from movies where Cast(zip as text) LIKE '%s';"% str(curZip))
          queryType='movies'
          query=cur.mogrify(query);
      else:
          query ="SELECT * from stores where (name LIKE '%%%s%%' OR type LIKE '%%%s%%') AND Cast(zip as text) LIKE '%s' ORDER BY name;"% (searchTerm, searchTerm,str(curZip));
          print "store"
          queryType = 'stores'
          query = cur.mogrify(query);
          print (query)
      cur.execute(query)
      rows=cur.fetchall()
      print "rows %d", len(rows)
      if(len(rows)==0):
          query = "SELECT * from movies where (movie LIKE '%%%s%%' OR theater LIKE '%%%s%%') AND Cast(zip as text) LIKE '%s' ORDER BY movie;" % (searchTerm, searchTerm, str(curZip));
          print (query)
          print ("movie")
          queryType = 'movies'
          query=cur.mogrify(query);
          cur.execute(query)
          rows=cur.fetchall()
    
    print "return"
    return render_template('index.html', queryType=queryType, results=rows, selectedMenu='Home', username=curUser)

@app.route('/login', methods=['GET', 'POST'])
def login():
    print "login"
    #global currentUser
    if('zip' in session):
        print 'zip exists do nothing'
        
    else:
        session['zip'] = '*'
    conn = connectToDB()
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    # if user typed in a post ...
    if request.method == 'POST':
      print "login, post"
      cu = request.form['username']
      session['zip'] = '*'

      pw = request.form['pw']
      query =cur.mogrify("select zipcode from users WHERE username = %s AND password = crypt(%s,password)",(cu, pw))
      print query
      cur.execute(query)
      z=cur.fetchone()
      if z!=None:
          session['currentUser']=cu
          session['zip']=str(z[0])
          print session['zip']
          return redirect(url_for('mainIndex'))
      else:
          session['currentUser']=''
          
    if 'currentUser' in session:
        username = session['currentUser']
    else:
        username=''
        
    return render_template('login.html', selectedMenu='Login', username=username)
    
@app.route('/register', methods=['GET', 'POST'])
def register():
    print "register"

    conn = connectToDB()
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
   
    if request.method == 'POST':
      print "POST"
      pas=request.form['password']
      user=request.form['username']
      zcode=request.form['zip']
      query = cur.mogrify("insert into users (username,password,zipcode) VALUES (%s, crypt(%s, gen_salt('bf')), %s)", (user, pas, zcode));
      print query
      try:
          cur.execute(query)
          conn.commit()
          print("inserted")
      except Exception as e: 
            print("Error inserting")
            print e
            conn.rollback()
        
    return render_template('register.html', selectedMenu='register')




if __name__ == '__main__':
    app.debug=True
    app.run(host='0.0.0.0', port=8080)
