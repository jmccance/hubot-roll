# Description:
#   Provides advanced die rolling functionality.
#
# Commands:
#   hubot roll NdM - rolls N M-sided dice and reports the result (N and reason are optional)
#   hubot roll NdM reason - rolls N M-sided dice and reports the result and why you rolled it
#
# Author:
#   jmccance
module.exports = (robot) ->
  isCritSuccess = (roll) -> roll == 20
  isCritFail = (roll) -> roll == 1

  robot.respond /roll (\d+)?d(\d+)( ?[+-]\d+)?( .*)?/i, (res) ->
    [_, num, sides, modifier, reason] = res.match.map((s) -> s.trim() if s?)
    num = if num? then parseInt(num) else 1
    sides = parseInt(sides)
    modifier = if modifier? then parseInt(modifier) else 0

    reason =
      if reason?
        r = reason.trim()
        r.charAt(0).toUpperCase() + r.substr(1)
      else
        'You rolled'

    roll = [1..sides]
    results = [1..num].map((a) -> res.random roll)
    total = results.reduce((a, b) -> a + b)

    resultsText =
      if num > 1
        ' (Rolls: ' + results.reduce((s, n) -> "#{s} #{n}") + ')'
      else
        ''

    # Only tests for 1d20 rolls
    critText = ''
    if num == 1 && sides == 20
      roll = results[0]
      if isCritSuccess(roll)
        critText = '*CRIT!* '
      else if isCritFail(roll)
        critText = '*CRIT FAIL!* '

    modifierText =
      if modifier == 0
        ''
      else if modifier > 0
        "+#{modifier}"
      else
        "-#{modifier}"

    res.reply "#{critText}#{reason}: #{total + modifier} (#{num}d#{sides}#{modifierText})#{resultsText}"
