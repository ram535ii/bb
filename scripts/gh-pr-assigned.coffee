# Description:
#   Notifies HUBOT_GITHUB_USERNAME when they have been assigned to a Pull Request
#
# Configuration:
#   HUBOT_GITHUB_EVENT_NOTIFIER_ROOM  - The default room to which message should go (recommend private chat, i.e. your Slack username)
#   HUBOT_GITHUB_USERNAME - The github user to check for pul request assignment
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

room = process.env["HUBOT_GITHUB_EVENT_NOTIFIER_ROOM"]
user = process.env["HUBOT_GITHUB_USERNAME"]

if !room?
  console.warn "A room must be specific for posting to, set HUBOT_GITHUB_EVENT_NOTIFIER_ROOM. For Slack just use the channel name, so to receive them directly just put your Slack username."

if !user?
  console.warn "A user to check for pull request assignment must be specified, set HUBOT_GITHUB_USERNAME to your github username."

module.exports = (robot) ->
  robot.router.post "/hubot/gh-repo-events", (req, res) ->
    data = req.body
    pr_url = data.pull_request.html_url

    if data.action == "assigned" && data.assignee.login == user
      robot.messageRoom room, "Sire, you have been assigned to a new pull request - do yourself a favor and check it here => " + pr_url

    res.end "{'status' : 200}"
