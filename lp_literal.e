note
	description: "{LP_LITERAL} models a single literal which form building blocks of expressions for example 2X"
	author: "Vivek Shah"
	date: "$Date$"
	revision: "$Revision$"

class
	LP_LITERAL

inherit ANY
	redefine
		out, is_equal
	end

create
	make_from, make

feature

	variable: STRING

	quantifier: INTEGER

	set_variable (new_variable: like variable)
		-- Setter method for the variable in the literal. Trims leading and trailing spaces
		do
			variable := new_variable

			-- Remove trailing and leading spaces
			variable.left_adjust
			variable.right_adjust
		ensure
			variable = new_variable
		end

	set_quantifier (new_quantifier: like quantifier)
		-- Setter method for quantifier in the literal
		do
			quantifier := new_quantifier
		ensure
			quantifier = new_quantifier
		end

	is_same (literal: attached LP_LITERAL): BOOLEAN
		-- Method to check if 2 literals have same variables.
		do
			Result := False
			if variable.is_equal (literal.variable) then
				Result := True
			else
				Result := False
			end
		end

	make_from(literal : attached LP_LITERAL)
		-- Create clause to create a literal from another literal
		do
			set_quantifier (literal.quantifier)
			set_variable (literal.variable)
		end

	make
		-- Create clause to create an empty literal
		do
			create variable.make_empty
			create quantifier.default_create
		end

	out : STRING
		-- String representation of the literal
		do
			create Result.make_empty
			Result.append(quantifier.out)
			Result.append(variable)
		end

	is_equal(other : like Current) : BOOLEAN
		-- Check if two literals are the same
		do
			Result := Precursor(other)
			if Result = False then
				if variable.is_equal (other.variable) and quantifier.is_equal (other.quantifier) then
					Result := True
				else
					Result := False
				end
			end
		end
end
