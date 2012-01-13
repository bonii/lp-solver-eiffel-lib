note
	description: "Summary description for {LP_OBJECTIVE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LP_OBJECTIVE

inherit ANY
	redefine
		out
	end

create
	make, make_from

feature
	expression : LP_EXPRESSION
	minimize : BOOLEAN

	set_expression(newexpression : like expression)
		do
			expression := newexpression
		ensure
			expression = newexpression
		end

	set_minimize(minflag : like minimize)
		do
			minimize := minflag
		ensure
			minimize = minflag
		end

	make
		do
			create expression.make
		end

	make_from(new_expression : like expression ; min_flag : like minimize)
		do
			create expression.make_from(new_expression.expression)
			minimize := min_flag
		end

	out : STRING
		do
			create Result.make_empty
			if minimize = True then
				expression.negate
			end
			Result.append (expression.out)
			Result.append (";")
		end
end
