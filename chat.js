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
  chat.message;
  chat.pass;
  chat.error;
  chat.online = false;
  chat.login = function() {
    com = {};
    com.command = "login";
    com.user = chat.user;
    com.password = chat.pass;
    socket.send(JSON.stringify(com));
  }
  chat.register = function() {
    com = {};
    com.command = "register";
    com.user = chat.user;
    com.password = chat.pass;
    socket.send(JSON.stringify(com));
  }
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
  }
  chat.update = function() {
    $scope.$apply();
  }
  chat.logout = function() {
    socket.send("");
    socket.close();
    socket = new WebSocket("ws://74.130.40.194:8080/");
    socket.onmessage = onmessage;
    chat.user = "";
    chat.pass = "";
    chat.online = false;
  }
};
  chat.inviteUser = function() {
	com = {};
	com.command = "invite";
	com.user = user id from the users list;
	com.channel= activechannel;
	socket.send(JSON.stringify(com));
	
	}
  chat.banUser = function() {
	com = {};
	com.command = "ban";
	com.User = user id from users list;
	com.channel = activechannel;
	socket.send(JSON.stringify(com));
	}
	
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
      break;

    case "channel":
      chat.messages[com.channel] = com.messages;
      break;
  }	
  chat.update();
}
socket.onmessage = onmessage;
