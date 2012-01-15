note
	description: "{LP_SIMPLE_MODEL_CHECKER} models a simple model checker which checks two models just by checking if they are the same reference"
	author: "Vivek Shah"
	date: "$Date$"
	revision: "$Revision$"

class
	LP_SIMPLE_MODEL_CHECKER

inherit
	LP_MODEL_CHECKER

feature

	is_same(model1 : LP_MODEL; model2 : LP_MODEL) : BOOLEAN
		-- Check if two models are the same by checking if they are the same reference
		do
			if model1 = model2 then
				Result := True
			else
				Result := False
			end
		end

end
