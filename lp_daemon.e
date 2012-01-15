note
	description: "{LP_DAEMON} models the abstract class to run lp solve jobs"
	author: "Vivek Shah"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LP_DAEMON

feature
	run_model(model : LP_MODEL)
		-- Runs the model provided as job
		-- Cache is an internal feature and should not be known to the client
		deferred
		end

end
