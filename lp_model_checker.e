note
	description: "{LP_MODEL_CHECKER} models the abstract model checker. More complicated model checking can be done by creating new model checkers and redefining the method"
	author: "Vivek Shah"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LP_MODEL_CHECKER

feature
	is_same(model1 : LP_MODEL; model2 : LP_MODEL) : BOOLEAN
		-- Check if two models are same, using more complicated algorithm which are not suitable for is_equal method of the model components
		-- Used by {LP_BLOCKING_DAEMON} to check if 2 models are same
		deferred
		end
end
