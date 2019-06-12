local Helpers = require "../autoreftesthelpers"

return Helpers.createReplayTestRunner(" main",
	Helpers.expectFirstEvent("keeper_held_ball", {
		Helpers.expectTeam(true), -- yellow
		}))
