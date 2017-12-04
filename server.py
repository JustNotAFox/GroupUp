import asyncio
import websockets
import json
import accounthandler
import messagehandler

LISTEN_ADDRESS = ('0.0.0.0',8080)
clients = {}
channels = {}

@asyncio.coroutine
def client_handler(websocket,path):
	cmd = yield from websocket.recv()
	cmd = json.loads(cmd)
	print(cmd)
	if cmd["command"] == "login":
		success = accounthandler.login(cmd)
		if not type(success) is str:
			if success[0] in clients.keys():
				success = "That account is already logged in"
	if cmd["command"] == "register":
		success = accounthandler.register(cmd)
	while type(success) is str:
		cmd = {"command": "fail", "error": success}
		yield from websocket.send(json.dumps(cmd))
		cmd = yield from websocket.recv()
		cmd = json.loads(cmd)
		print(cmd)
		if cmd["command"] == "login":
			success = accounthandler.login(cmd)
			if not type(success) is str:
				if success[0] in clients.keys():
					success = "That account is already logged in"
		if cmd["command"] == "register":
			success = accounthandler.register(cmd)
	uid = success[0]
	chan = accounthandler.getchannels(uid)
	clients[uid] = {"socket": websocket, "channels": list(chan)}
	yield from websocket.send(json.dumps({"command":"success", "channels": chan, "uid": uid}))
	for c in chan:
		if c[2] and c[2] > 1:
			if c[0] in channels.keys():
				channels[c[0]].append(uid)
			else:
				channels[c[0]] = [uid]
			yield from websocket.send(json.dumps(messagehandler.initchannel(c[0])))
	while True:
		cmd = yield from websocket.recv()
		if cmd == "":
			for c in clients[uid]["channels"]:
				channels[c[0]].remove(uid)
			del clients[uid]
			break
		print(cmd)
		cmd = json.loads(cmd)
		if cmd["command"] == "message":
			yield from messagehandler.send(uid,cmd,[clients[a]["socket"] for a in channels[cmd["channel"]]])
		elif cmd["command"] == "ban":
			tmp = accounthandler.ban(uid, cmd)
			if tmp:
				if tmp[0] == 0:
					msg = json.dumps({"command": "banned", "channel": cmd["cid"], "uid": cmd["uid"]})
					for ids in channels[cmd["cid"]]:
						yield from clients[ids]["socket"].send(msg)
					if cmd["uid"] not in channels[cmd["cid"]]:
						if cmd["uid"] in clients.keys():
							yield from clients[cmd["uid"]]["socket"].send(msg)
					if cmd["uid"] in channels[cmd["cid"]]:
						channels[cmd["cid"]].remove(cmd["uid"])
						clients[cmd["uid"]].remove(cmd["cid"])
		elif cmd["command"] == "invite":
			tmp = accounthandler.invite(uid, cmd)
			print(tmp)
			if tmp:
				if tmp[0] == 1:
					msg = json.dumps({"command": "invited", "channel": cmd["cid"], "uid": cmd["uid"], "name": accounthandler.getchannelname(cmd["cid"])[0]})
					for ids in channels[cmd["cid"]]:
						yield from clients[ids]["socket"].send(msg)
					if cmd["uid"] in clients.keys():
						yield from clients[cmd["uid"]]["socket"].send(msg)
		elif cmd["command"] == "create":
			tmp = accounthandler.create(uid, cmd)
			channels[tmp[0]] = [uid]
			clients[uid]["channels"].append(tmp[0])
			msg = {}
			msg["command"] = "newchannel"
			msg["uid"] = uid
			msg["channel"] = [tmp[0], cmd["name"]]
			if cmd["private"] == 0:
				for client in clients.keys():
					yield from clients[client]["socket"].send(json.dumps(msg))
			else:
				yield from websocket.send(json.dumps(msg))
			yield from websocket.send(json.dumps(messagehandler.initchannel(tmp[0])))
		elif cmd["command"] == "join":
			tmp = accounthandler.join(uid,cmd)
			if tmp:
				if tmp[0] == 2:
					msg = json.dumps({"command": "joined", "channel": cmd["cid"], "uid": uid})
					if cmd["cid"] in channels.keys():
						channels[cmd["cid"]].append(uid)
					else:
						channels[cmd["cid"]] = [uid]
					clients[uid]["channels"].append(cmd["cid"])
					for ids in channels[cmd["cid"]]:
						yield from clients[ids]["socket"].send(msg)
					yield from websocket.send(json.dumps(messagehandler.initchannel(cmd["cid"])))
		elif cmd["command"] == "pass":
			yield from accounthandler.passwd(uid,cmd)

start_server = websockets.serve(client_handler, *LISTEN_ADDRESS)
asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()
