local Helpers = require "../autoreftesthelpers"

return Helpers.createReplayTestRunner(" main",
	Helpers.expectEventMultiple("possible_goal", {
		Helpers.expectTeam(false), -- blue
		}, 1, 1))
