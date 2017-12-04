import json
import pymysql

db = pymysql.connect(host='localhost',
		     user='root',
		     password='password',
		     db='Group_Up',
                     autocommit = True)

def send(user, com, clients):
	cursor = db.cursor()
	cursor.execute("CALL addmessage(%s,%s,%s)", (user,com["channel"],com["message"]))
	tmp = cursor.fetchone()
	print(tmp)
	message = {"id": tmp[0], "channel": tmp[1], "message": tmp[2], "user": tmp[3], "timestamp": str(tmp[4])}
	for client in clients:
		yield from client.send(json.dumps({"command": "message", "message": message}))

def initchannel(channel):
	cursor = db.cursor()
	cursor.execute("CALL getmessage(%s)", (channel))
	tmp = cursor.fetchall()
	cursor.execute("CALL getusers(%s)",(channel))
	return {"command": "channel", "channel": channel, "messages": [{"id": a[0], "channel": a[1], "message": a[2], "user": a[3], "timestamp": str(a[4])} for a in tmp], "users": [{"id": a[0], "name": a[1], "role": a[2]} for a in cursor.fetchall()]}
