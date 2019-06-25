local Helpers = require "../autoreftesthelpers"

return Helpers.createReplayTestRunner(" main",
	Helpers.expectEventMultiple("attacker_touched_opponent_in_defense_area", {
		Helpers.expectTeam(false), -- blue
		Helpers.expectBotId(6),
		--Helpers.expectRoughLocation(0, 0)
		}))
