# hubot-roll

Hubot-roll is a polyhedral die roller for your Hubot instances.

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
