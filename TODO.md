# List of Stuff to Refactor

- Think about adding functionality to the player to allow for
processing multiple moves for one request. Special return value from
get next move. Or have it be a lookup method on the player class that
says "you need to block/go to the user" whatever that means.

Is this something I can make useful for the console?

- will_block? is a bad name. But it's unclear what a better one is
since I'm not actually using it yet. Maybe it's not so bad. It is
actually about whether the move will require blocking since on
receiving a move request the Web human player object will not be
required to block


- Things I need.  the id's, then `document.getElementById("move*")`.  Then I can add
  classes with `el.parentElement.classList.add("*-marker")`. For click
  events `el.onclick = function (){}` works, and `el.disable = true`
  will disable the input element.

- I can make a class for manipulating one of these option elements. It
  get's injected with the DOM element that it needs to point to.
  Then, since I'm not adding and removing DOM elements I can just keep
  a list of those class objects. Then I can test their behavior sans-DOM.
