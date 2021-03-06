# Description:
#   makes it possible to prove by coq in chat room
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

  robot.respond /proof put (\d+) (.+)$/i, (msg) ->
    id = msg.match[1]
    data = JSON.stringify({
      command: msg.match[2]
    })
    robot.http(url + "/command/" + id)
      .post(data) (err, res, body) ->
        if err
          msg.send "Error: #{err}"
        else
          output = JSON.parse(body)
          if output.error_output
            msg.send "ID: #{id}\n\n#{output.error_output.output}"
          else
            msg.send "ID: #{id}\n\n#{output.last_output.output}"

  robot.respond /proof terminate (\d+)$/i, (msg) ->
    id = msg.match[1]
    robot.http(url + "/terminate/" + id)
      .delete() (err, res, body) ->
        if err
          msg.send "Error: #{err}"
        else
          msg.send "ID: #{id} have been terminated"
