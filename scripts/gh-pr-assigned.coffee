module.exports = (robot) ->
  robot.router.post "/hubot/gh-repo-events", (req, res) ->
    if req.body.assignee.login = "ram535ii"
      console.log "Pull request assigned to constantijn"
      robot.messageRoom "constantijnschepens", "ASSIGNED BIATCH"
