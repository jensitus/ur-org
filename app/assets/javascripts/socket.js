var wsUri = "ws://echo.websocket.org/";
var scheme = "ws://";
//var wsUri = scheme + window.document.location.host + "/";
var output;
websocket = new WebSocket(wsUri);

function WebSocketTest() {
    document.getElementById("connect").disabled = false;
    document.getElementById("disconnect").disabled = true;
    document.getElementById("anzeige").innerHTML = wsUri;
}

function start() {
    output = document.getElementById("anzeige");

    websocket.onopen = function(evt) { onOpen(evt)};
    onOpen();

    document.getElementById("connect").disabled = true;
    document.getElementById("disconnect").disabled = false;
    document.getElementById("sendMessage").disabled = false;
    document.getElementById("send").disabled = false;

    if (websocket.readyState == WebSocket.CLOSED) {
        writeToScreen("close")
    } else if (websocket.readyState == WebSocket.OPEN) {
        writeToScreen("open")
    }
}

function stop() {
    output = document.getElementById("anzeige");
    websocket.onclose = function(evt) {
        onClose(evt)
    };
    onClose();
    document.getElementById("connect").disabled = false;
    document.getElementById("disconnect").disabled = true;
    document.getElementById("sendMessage").disabled = true;
    document.getElementById("send").disabled = true;

    if (websocket.readyState == WebSocket.CLOSING) {
        writeToScreen("closed");
    } else {
        writeToScreen("don't know, maybe closed");
    }

}

function testWebSocket() {
    websocket = new WebSocket(wsUri);
    websocket.onopen = function(evt) { onOpen(evt) };
    websocket.onclose = function(evt) { onClose(evt) };
    websocket.onmessage = function(evt) { onMessage(evt) };
    websocket.onerror = function(evt) { onError(evt) };
}

function onOpen(evt) {
    writeToScreen("CONNECTED");
    doSend("WebSocket rocks");
}

function onClose(evt) {
    writeToScreen("DISCONNECTED");
}

function onMessage(evt) {
    writeToScreen('<span style="color: blue;">RESPONSE: ' + evt.data +'</span>');
    websocket.close();
}

function onError(evt) {
    writeToScreen('<span style="color: red;">ERROR:</span> ' + evt.data);
}

function doSend(message) {
    message = document.getElementById('sendMessage').value;
    writeToScreen("SENT: " + message);
    websocket.send("message");

}

function writeToScreen(message) {
    var pre = document.createElement("p");
    pre.style.wordWrap = "break-word";
    pre.innerHTML = message;
    output.appendChild(pre);
}



//window.addEventListener("load", begin, false);                      jjj --