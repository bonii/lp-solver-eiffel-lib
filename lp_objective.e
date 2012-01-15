note
	description: "{LP_OBJECTIVE} models the objective function."
	author: "Vivek Shah"
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
		-- Set the expression in the objective
		do
			expression := newexpression
		ensure
			expression = newexpression
		end

	set_minimize(minflag : like minimize)
		-- Set the minimize flag to denote if the objective is to minimize of maximize
		do
			minimize := minflag
		ensure
			minimize = minflag
		end

	make
		-- Create an empty objective
		do
			create expression.make
			create minimize.default_create
		end

	make_from(new_expression : like expression ; min_flag : like minimize)
		-- Create an objective from the constituent components
		do
			set_expression (new_expression)
			set_minimize (min_flag)
		end

	out : STRING
		-- Generate a string representation of the objective in LP format
		-- If it is minimization job negate the objective expression
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
		-- Check if two objectives are the same
		do
			Result := Precursor(other)
			if Result = False then
				if minimize.is_equal(other.minimize) then
					Result := expression.is_equal (other.expression)
				else
					-- Check whether a minimization objective is not same as a maximisation objective
					Result := expression.is_equal (other.expression.negated_dup)
				end
			end
		end
end
