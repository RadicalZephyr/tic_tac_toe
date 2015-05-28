function disableOptions() {
  for (var i = 0; i < 9; i++) {
    options[i].disabled = true;
  }
}

function enableOptions() {
  for (var i = 0; i < 9; i++) {
    options[i].disabled = false;
  }
}

function setNewBoard(board) {
  for (var i = 0; i < 9; i++) {
    if (board[i] !== " ") {
      options[i].parentElement.classList.add(board[i].toUpperCase()+"-marker");
    }
  }
}

function getCurrentBoard() {
  var oReq = new XMLHttpRequest();
  oReq.onload = function() {
    var boardInfo = JSON.parse(this.responseText);
    if (boardInfo.marks !== null) {
      setNewBoard(boardInfo.marks);
    }
    enableOptions();
  };
  oReq.open("GET", "api/board", true);
  oReq.send();
}

function sendMove(move) {
  var oReq = new XMLHttpRequest();
  oReq.onload = function() {
    getCurrentBoard();
  };
  oReq.open("POST", "api/make-move", true);
  oReq.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
  oReq.send("move="+move);
}

function makeOnClick(optEl) {
  var index = optEl.value;
  return function() {
    disableOptions();
    sendMove(index);
  };
}

var submitBtn = document.getElementById("submit-btn");
submitBtn.classList.add("hidden");

var options = [];

for (var i = 0; i < 9; i++) {
  var opt = document.getElementById("move"+i);
  options.push(opt);
  opt.onclick = makeOnClick(opt);
}
