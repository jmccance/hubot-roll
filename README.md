# hubot-roll

Hubot-roll is a polyhedral die roller for your Hubot instances.

## Configuration

There are two optional environment variables you can set for hubot-roll. There are reasonable defaults set for both of these, so you shouldn't need to fiddle with them unless you want to.

* `HUBOT_ROLL_MAX_ROLL` (Default: 1e6): Sets the maximum magnitude of a roll to prevent users from crashing your Hubot. The magnitude of a roll is the produce of the number of dice and the sides per die.
* `HUBOT_ROLL_MAX_RESULTS` (Default: 100): Sets a cutoff past which hubot-roll won't display individual results. This protects you from spammy interactions like `hubot roll 1000000d1`.

## Examples

```
hubot> hubot help roll
hubot roll NdM - rolls N M-sided dice and reports the result (N and reason are optional)
hubot roll NdM reason - rolls N M-sided dice and reports the result and why you rolled it
hubot> hubot roll d20
Shell: You rolled: 10 (1d20)
hubot> hubot roll d20 initiative
Shell: Initiative: 6 (1d20)
hubot> hubot roll 6d6+4 damage
Shell: Damage: 24 (6d6+4) (Rolls: 1 6 3 4 1 5)
hubot> hubot roll d20 +2
Shell: *CRIT!* You rolled: 22 (1d20+2)
hubot> hubot roll d20 +2
Shell: *CRIT FAIL!* You rolled: 3 (1d20+2)
```
