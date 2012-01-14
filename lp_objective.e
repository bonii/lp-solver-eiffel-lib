note
	description: "Summary description for {LP_OBJECTIVE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LP_OBJECTIVE

inherit ANY
	redefine
		out, is_equal
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
			set_expression (new_expression)
			set_minimize (min_flag)
		end

	out : STRING
		do
			create Result.make_empty
			if minimize = True then
				Result.append (expression.negated_dup.out)
			else
				Result.append (expression.out)
			end

			Result.append (";")
		end

	is_equal(other : like Current) : BOOLEAN
		do
			if minimize.is_equal(other.minimize) then
				Result := expression.is_equal (other.expression)
			else
				Result := expression.is_equal (other.expression.negated_dup)
			end
		end
end
