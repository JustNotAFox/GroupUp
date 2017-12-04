import pymysql

db = pymysql.connect(host='localhost',
		     user='root',
		     password='password',
		     db='Group_Up',
                     autocommit = True)

def login(com):
	cursor = db.cursor()
	cursor.execute("CALL login(%s,%s)", (com['user'], com['password']))
	success = cursor.fetchone()
	if success:
		return success
	return 'Invalid username or password'

def register(com):
	cursor = db.cursor()
	success = cursor.execute("CALL register(%s, %s)", (com['user'], com['password']))
	success = cursor.fetchone()
	if success:
		return success
	return 'An account with that name already exists'

def getchannels(uid):
	cursor = db.cursor()
	cursor.execute("CALL getchannels(%s)", (uid))
	return cursor.fetchall()

def getchannelname(cid):
	cursor = db.cursor()
	cursor.execute("select name from Groupchannel where id = %s;", (cid))
	return cursor.fetchone()

def ban(uid, cmd):
	cursor = db.cursor()
	cursor.execute("CALL ban(%s,%s,%s)", (uid, cmd["uid"], cmd["cid"]))
	return cursor.fetchone()

def invite(uid, cmd):
	cursor = db.cursor()
	cursor.execute("CALL invite(%s,%s,%s)",(uid,cmd["uid"],cmd["cid"]))
	return cursor.fetchone()

def create(uid,cmd):
	cursor = db.cursor()
	cursor.execute("CALL createchannel(%s,%s,%s)",(uid,cmd["name"],cmd["private"]))
	return cursor.fetchone()

def join(uid,cmd):
	cursor = db.cursor()
	cursor.execute("CALL joinchannel(%s,%s)",(uid,cmd["cid"]))
	return cursor.fetchone()

def passwd(uid,cmd):
	cursor = db.cursor()
	cursor.execute("CALL passwd(%s,%s,%s)",(uid,cmd["oldpass"],cmd["newpass"]))
	return cursor.fetchone()
