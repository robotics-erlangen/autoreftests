local Helpers = require "../autoreftesthelpers"

return Helpers.createReplayTestRunner(" main",
	Helpers.expectFirstEvent("defender_in_defense_area_partially", {
		Helpers.expectTeam(false), -- blue
		}))
