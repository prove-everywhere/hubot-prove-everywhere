hubot-prove-everywhere
======================

This is a hubot plugin to use prove-everywhere.

This plugin makes it possible to use Coq in your chat room!

Installation
------------

- add `"hubot-prove-everywhere": ""` to your hubot's `package.json`
- add `"hubot-prove-everywhere"` to `external-scripts.json`
- set `HUBOT_PROVE_EVERYWHERE_URL` as an enviroment variable
  - URL of your prove-everywhere-server
  - e.g., `http://amutake.me:50905`

Usage
-----

- `hubot proof new`
  - creates new coqtop and returns coqtop id
- `hubot proof put <id> <command>`
  - sends command to coqtop
- `hubot proof terminate <id>`
  - terminates coqtop
