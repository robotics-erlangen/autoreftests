local Helpers = require "../autoreftesthelpers"

return Helpers.createReplayTestRunner(" main",
	Helpers.expectEventMultiple("possible_goal", {
		Helpers.expectTeam(true), -- blue
		}, 1, 1))
