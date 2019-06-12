local Helpers = require "../autoreftesthelpers"

return Helpers.createReplayTestRunner(" main",
	Helpers.expectEventMultiple("aimless_kick", {
		Helpers.expectTeam(false), -- blue
		}, 1, 1))
