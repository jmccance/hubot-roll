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
  # Maximum roll to make. A "roll" is the product of the number of dice and the
  # number of sides on those dice.
  MAX_ROLL = process.env.HUBOT_ROLL_MAX_ROLL ? 1e6

  # Maximum number of individual results to show.
  MAX_RESULTS = process.env.HUBOT_ROLL_MAX_RESULTS ? 100

  robot.respond /roll (\d+)?d(\d+)( ?[+-]\d+)?( .*)?/i, (res) ->
    # Perform the roll. This may result in an error, so both an error handler
    # and a success handler are required.
    roll = (numDice, numSides, errorHandler, successHandler) ->
      if numDice * numSides > MAX_ROLL
        errorHandler "Error: Roll exceeded maximum magnitude (#{numDice} * " +
            "#{numSides} > #{MAX_ROLL})."
      else
        sides = [1..numSides]
        results = [1..numDice].map((a) -> res.random sides)
        successHandler results

    # Compute the response text given an array of results.
    responseTextForResults = (results) ->
      total = results.reduce (a, b) -> a + b

      resultsText =
        if num > MAX_RESULTS
          " (Individual rolls not shown when rolling >#{MAX_RESULTS} dice.)"
        else if num > 1
          ' (Rolls: ' + (results.reduce (s, n) -> "#{s} #{n}") + ')'
        else
          ''

      # Only tests for 1d20 rolls
      critText =
        if num == 1 && sides == 20
          critTextForRoll results[0]
        else
          ''

      modifierText =
        if modifier == 0
          ''
        else if modifier > 0
          "+#{modifier}"
        else
          "#{modifier}"

      "#{critText}#{reason}: #{total + modifier} " +
        "(#{num}d#{sides}#{modifierText})#{resultsText}"

    # Compute text for if the roll was a crit success, crit fail, or neither.
    critTextForRoll = (roll) ->
      switch roll
        when 1  then  '*CRIT FAIL!* '
        when 20 then  '*CRIT!* '
        else          ''

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

    responseText = roll num, sides,
      (e) -> e,
      (results) -> responseTextForResults results

    res.reply responseText
