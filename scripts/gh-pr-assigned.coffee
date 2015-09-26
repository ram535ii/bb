module.exports = (robot) ->
  robot.router.post "/hubot/gh-repo-events", (req, res) ->
    console.log "RECEIVED"
    console.log req.body
