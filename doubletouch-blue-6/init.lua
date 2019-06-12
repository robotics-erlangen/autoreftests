local Helpers = require "../autoreftesthelpers"

return Helpers.createReplayTestRunner(" main",
	Helpers.expectEventMultiple("attacker_double_touched_ball", {
		Helpers.expectTeam(false), -- blue
		Helpers.expectBotId(6),
		--Helpers.expectRoughLocation(0, 0)
		}))
