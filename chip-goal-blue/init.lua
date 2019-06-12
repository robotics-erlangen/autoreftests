local Helpers = require "../autoreftesthelpers"

return Helpers.createReplayTestRunner(" main",
	Helpers.expectEventMultiple("chipped_goal", {
		Helpers.expectTeam(false), -- blue
		}, 1, 1))
