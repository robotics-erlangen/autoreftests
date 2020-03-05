local Helpers = require "../autoreftesthelpers"

return Helpers.createReplayTestRunner(" main",
	Helpers.expectEventMultiple("placement_failed", {
		Helpers.expectTeam(false), -- blue
		}, 1))
