# Description:
#   Notifies Github user when they have been assigned to a Pull Request in their chat client of choice
#
# Configuration:
#   HUBOT_GITHUB_EVENT_NOTIFIER_ROOMS  - The rooms to which message should go,
#                                        comma-separated (i.e. your Slack username)
#   HUBOT_GITHUB_USERNAMES - The github user to check for pull request assignment
#   (NOTE: rooms and usernames should match in order
#   i.e. HUBOT_GITHUB_EVENT_NOTIFIER_ROOMS = room1, room2
#        HUBOT_GITHUB_USERNAMES            = user1, user2
#   )
#
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
#   Thanks to https://github.com/hubot-scripts/hubot-github-repo-event-notifier for inspiration

rawRooms = process.env["HUBOT_GITHUB_EVENT_NOTIFIER_ROOMS"]
rawUsers = process.env["HUBOT_GITHUB_USERNAMES"]

splitAndSanitiseEnvVars = (commaSeparatedList) ->
  commaSeparatedList.split(",").map((item) ->
    item.trim()
  )

# Validate Inputs
if rawRooms?
  rooms = splitAndSanitiseEnvVars(rawRooms)
else
  console.warn "Rooms must be specified for posting to, set HUBOT_GITHUB_EVENT_NOTIFIER_ROOM."

if rawUsers?
  users = splitAndSanitiseEnvVars(rawUsers)
else
  console.warn "Users to check for pull request assignment must be specified, set HUBOT_GITHUB_USERNAME to your github username."

module.exports = (robot) ->
  robot.router.post "/hubot/gh-repo-events", (req, res) ->
    data = req.body
    pr_url = data.pull_request.html_url

    if data.action == "assigned"
      for user, i in users
        if data.assignee.login == user
          robot.messageRoom rooms[i], "Sire, you have been assigned to a new pull request - do yourself a favor and check it here => " + pr_url

    res.end "{'status' : 200}"
