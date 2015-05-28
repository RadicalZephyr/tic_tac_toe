var submitBtn = document.getElementById("submit-btn");
submitBtn.classList.add("hidden");

var options = [];

for (var i = 0; i < 9; i++) {
  options.push(document.getElementById("move"+i));
}

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
  };
  oReq.open("GET", "api/board", true);
  oReq.send();
}
