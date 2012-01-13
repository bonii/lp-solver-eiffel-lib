note
	description: "Summary description for {LP_MODEL_LIST_CHECKER}."
	author: ""
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
	do
		Result := Precursor(model1,model2)
		if Result = False then
			Result := model1.is_equal (model2)
		end
	end
end
