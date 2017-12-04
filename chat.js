var myApp = angular.module('myApp',[]);
myApp.controller("chatCtrl", ChatCtrl);
var chat;
var socket = new WebSocket("ws://74.130.40.194:8080/");
function ChatCtrl($scope) {
  chat = this;
  chat.messages = [];
  chat.channels = [];
  chat.activechannel = 1;
  chat.user;
  chat.users = [];
  chat.admins = [];
  chat.members = [];
  chat.invitedUsers = [];
  chat.bannedUsers = [];
  chat.settings = false;
  chat.message;
  chat.pass;
  chat.error;
  chat.private = 0;
  chat.online = false;
  chat.login = function() {
    com = {};
    com.command = "login";
    com.user = chat.user;
    com.password = chat.pass;
    socket.send(JSON.stringify(com));
  };
  chat.register = function() {
    com = {};
    com.command = "register";
    com.user = chat.user;
    com.password = chat.pass;
    socket.send(JSON.stringify(com));
  };
  chat.sendMessage = function() {
    com = {};
    com.command = "message";
    com.message = chat.message;
    com.channel = chat.activechannel;
    socket.send(JSON.stringify(com));
    chat.message = "";
  };
  chat.addMessage = function(message) {
    chat.messages[message.channel].push(message);
    if(message.channel == chat.activechannel) {
      $scope.$apply();
      var elem = document.getElementById("chatbox");
      elem.scrollTop = elem.scrollHeight;
    }
  };
  chat.update = function() {
    $scope.$apply();
  };
  chat.logout = function() {
    socket.send("");
    socket.close();
    socket = new WebSocket("ws://74.130.40.194:8080/");
    socket.onmessage = onmessage;
    chat.user = "";
    chat.pass = "";
    chat.online = false;
  };
  chat.inviteUser = function() {
    com = {};
    com.command = "invite";
    t = chat.users[chat.activechannel].find(function(t) { return t.name == chat.invbanname; })
	if(!t) {
		t = chat.users[1].find(function(t) { return t.name == chat.invbanname; })
	}
	if(!t) {
		return;
	}
    com.uid = t.id;
    com.cid = chat.activechannel;
    socket.send(JSON.stringify(com));
  };
  chat.banUser = function() {
    com = {};
    com.command = "ban";
    t = chat.users[chat.activechannel].find(function(t) { return t.name == chat.invbanname; })
	if(!t) {
		t = chat.users[1].find(function(t) { return t.name == chat.invbanname; })
	}
	if(!t) {
		return;
	}
    com.uid = t.id;
    com.cid = chat.activechannel;
    socket.send(JSON.stringify(com));
  };
  chat.createChannel = function(){
    com = {};
    com.command = "create";
    com.name = chat.newchannel;
    com.private = chat.private;
    socket.send(JSON.stringify(com));
  };
  chat.joinchannel = function(cid) {
     com = {};
	 com.command = "join"
	 com.cid = cid;
	 socket.send(JSON.stringify(com));
  }
  chat.isAdmin = function() {
    t = chat.users[chat.activechannel].find(function(t) { return t.id == chat.uid; })
    if(t.role == 3) {
      return true;
    }
    return false;
  }
}


myApp.filter('admins',function(){
  return function(input)
  {
    var out = [];
      angular.forEach(input,function(user){
        if(user.role == 3){
          out.push(user)
        }
      })
    return out;
  }
});
myApp.filter('members',function(){
  return function(input)
  {
    var out = [];
    angular.forEach(input,function(user){
      if(user.role == 2){
        out.push(user)
      }
    })
    return out;
  }
});
myApp.filter('invitedUsers',function(){
  return function(input)
  {
    var out = [];
    angular.forEach(input,function(user){
      if(user.role == 1){
        out.push(user)
      }
    })
    return out;
  }
});
myApp.filter('bannedUsers',function(){
  return function(input)
  {
    var out = [];
    angular.forEach(input,function(user){
      if(user.role == 0){
        out.push(user)
      }
    })
    return out;
  }
});
myApp.filter('channelsin',function(){
  return function(input)
  {
    var out = [];
    angular.forEach(input,function(ch){
      if(ch[2] > 1){
        out.push(ch)
      }
    })
    return out;
  }
});
myApp.filter('invited',function(){
  return function(input)
  {
    var out = [];
    angular.forEach(input,function(ch){
      if(ch[2] == 1){
        out.push(ch)
      }
    })
    return out;
  }
});
myApp.filter('public',function(){
  return function(input)
  {
    var out = [];
    angular.forEach(input,function(ch){
      if(!ch[2]){
        out.push(ch)
      }
    })
    return out;
  }
});

onmessage = function (event) {
  var com = JSON.parse(event.data);
  switch(com.command) {
    case "message":
      chat.addMessage(com.message);
      break;

    case "fail":
      chat.error = com.error;
      break;

    case "success":
      chat.messages = [];
      chat.channels = com.channels;
      chat.online = true;
      chat.error = "";
      chat.uid = com.uid;
      break;

    case "channel":
      chat.messages[com.channel] = com.messages;
      chat.users[com.channel] = com.users;
      break;
	  
	case "settings":
		chat.settingsChanged();
		break;
	case "createchannel":
		chat.createChannel(com.createchannel);
		break;

    case "banned":
      if(com.uid == chat.uid) {
        chat.messages.splice(com.channel);
        chat.users.splice(com.channel);
		i = chat.channels.findIndex(function(t) { return t.id == com.uid; });
		chat.channels.splice(i);
      }
      else {
        i = chat.users[com.channel].find(function(t) { return t.id == com.uid; });
        i.role = 0;
      }
      chat.update();
      break;

    case "invited":
      if(com.uid == chat.uid) {
		t = chat.channels.find(function(t) { return t.id == com.uid; });
		if (!t) {
			chat.channels.push([com.channel,com.name,1])
		}
		else {
			t[2] = 1;
		}
      }
      else {
        i = chat.users[com.channel].find(function(t) { return t.id == com.uid; });
        if(i) {
          i.role = 1;
        }
        else {
          i = chat.users[1].find(function(t) { return t.id == com.uid; });
          t = {};
          t.id = i.id;
          t.name = i.name;
          t.role = 1;
          chat.users[com.channel].push(t);
        }
      }
      chat.update();
      break;

    case "joined":
	  if(chat.uid != com.uid) {
		  i = chat.users[com.channel].find(function(t) { return t.id == com.uid; });
	  if(i) {
        i.role = 2;
      }
      else {
          i = chat.users[1].find(function(t) { return t.id == com.uid; });
          t = {};
          t.id = i.id;
          t.name = i.name;
          t.role = 2;
          chat.users[com.channel].push(t);
	  }
	  }
	  else {
		  i = chat.channels.find(function(t) { return t[0] == com.channel; });
		  i[2] = 2;
	  }
	  break;
	  
	  case "newchannel":
	  if(chat.uid == com.uid) {
		  com.channel[2] = 3;
	  }
		  chat.channels.push(com.channel)
  break;
  }
  chat.update();
}
socket.onmessage = onmessage;
