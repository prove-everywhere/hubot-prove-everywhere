# Description:
#   makes it possible to prove by coq in a chat room
#
# Configuration:
#   HUBOT_PROVE_EVERYWHERE_URL (required)
#
# Commands:
#   hubot proof new - makes new proof
#   hubot proof put <id> <script> - puts the script to coqtop
#   hubot proof terminate <id> - terminates coqtop
#
# Author:
#   amutake

module.exports = (robot) ->

  url = process.env.HUBOT_PROVE_EVERYWHERE_URL

  if !url
    return robot.logger.error """
      Please specify HUBOT_PROVE_EVERYWHERE_URL
    """

  robot.respond /proof new$/i, (msg) ->
    robot.http(url + "/start")
      .post() (err, res, body) ->
        if err
          msg.send "Error: #{err}"
        else
          info = JSON.parse(body)
          msg.send "ID: #{info.id}\n\n#{info.output}"

  robot.respond /proof put (\d+) (\.+)$/i, (msg) ->
    msg.reply "not implemented yet"

  robot.respond /proof terminate (\d+)$/i, (msg) ->
    msg.reply "not implemented yet"
