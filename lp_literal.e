note
	description: "Summary description for {LP_LITERAL}."
	author: "Vivek Shah"
	date: "$Date$"
	revision: "$Revision$"

class
	LP_LITERAL

inherit ANY
	redefine
		out
	end

create
	make_from, make

feature

	variable: STRING

	quantifier: INTEGER

	set_variable (new_variable: like variable)
		do
			variable := new_variable
		ensure
			variable = new_variable
		end

	set_quantifier (new_quantifier: like quantifier)
		do
			quantifier := new_quantifier
		ensure
			quantifier = new_quantifier
		end

	is_same (literal: attached LP_LITERAL): BOOLEAN
		do
			Result := False
			if variable.is_equal (literal.variable) then
				Result := True
			else
				Result := False
			end
		end

	make_from(literal : attached LP_LITERAL)
	do
		set_quantifier (literal.quantifier)
		set_variable (literal.variable)
	end

	make
	do
		create variable.make_empty
		create quantifier.default_create
	end

	out : STRING
	do
		create Result.make_empty
		Result.append(quantifier.out)
		Result.append(variable)
	end
end
