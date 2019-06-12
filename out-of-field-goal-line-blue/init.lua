local Helpers = require "../autoreftesthelpers"

return Helpers.createReplayTestRunner(" main",
	Helpers.expectEventMultiple("ball_left_field_goal_line", {
		Helpers.expectTeam(false), -- blue
		}, 1, 1))
