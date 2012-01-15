note
	description: "{LP_MODEL_LIST_CHECKER} is an advanced model checker which checks list equality in any order and LP object equality"
	author: "Vivek Shah"
	date: "$Date$"
	revision: "$Revision$"

class
	LP_MODEL_LIST_CHECKER

inherit
	LP_SIMPLE_MODEL_CHECKER
	redefine
		is_same
	end

feature

	is_same(model1 : LP_MODEL; model2 : LP_MODEL) : BOOLEAN
		-- Check if two models are the same using the LP data equality and list out of order equality
		do
			Result := Precursor(model1,model2)
			if Result = False then
				Result := model1.is_equal (model2)
			end
		end
end
