local Helpers = require "../autoreftesthelpers"

return Helpers.createReplayTestRunner(" main",
	Helpers.expectEventMultiple("attacker_touched_keeper", {
		Helpers.expectTeam(true), -- yellow
		Helpers.expectBotId(14),
		--Helpers.expectRoughLocation(0, 0)
		}))
