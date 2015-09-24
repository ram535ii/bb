module.exports = (robot) ->
  robot.hear /hai/i, (res) ->
    response = "Hai friend!"
        res.reply response
          return
