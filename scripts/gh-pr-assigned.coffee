# Description:
#   Notifies ram535ii when he has been assigned to a PR
#
# Configuration:
#   You will have to do the following:
#   1. Create a new webhook for your `myuser/myrepo` repository at:
#    https://github.com/myuser/myrepo/settings/hooks/new
#
#   2. Select the individual events to minimize the load on your Hubot.
#
#   3. Add the url: <HUBOT_URL>:<PORT>/hubot/gh-repo-events
#
# Commands:
#   None
#
# URLS:
#   POST /hubot/gh-repo-events
#
# Authors:
#   ram535ii
module.exports = (robot) ->
  robot.router.post "/hubot/gh-repo-events", (req, res) ->
    data = req.body
    if data.action == "assigned" && data.assignee.login == "ram535ii"
      console.log "Pull request assigned to constantijn"
      robot.messageRoom "constantijnschepens", "ASSIGNED TO A NEW PR BIATCH - check it here => " + req.body.pull_request.html_url

    res.end "{'status' : 200}"
