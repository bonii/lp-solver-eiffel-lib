note
	description: "Summary description for {LP_SIMPLE_MODEL_CHECKER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LP_SIMPLE_MODEL_CHECKER

inherit
	LP_MODEL_CHECKER

feature

	is_same(model1 : LP_MODEL; model2 : LP_MODEL) : BOOLEAN
		do
			if model1 = model2 then
				Result := True
			else
				Result := False
			end
		end

end
