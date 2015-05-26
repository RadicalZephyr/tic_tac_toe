# List of Stuff to Refactor

- Think about adding functionality to the player to allow for
processing multiple moves for one request. Special return value from
get next move. Or have it be a lookup method on the player class that
says "you need to block/go to the user" whatever that means.

Is this something I can make useful for the console?

- will_block? is a bad name. But it's unclear what a better one is
since I'm not actually using it yet.

- Setup an injectable "strategy" for the game to handle invalid moves
