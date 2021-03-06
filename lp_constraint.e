note
	description: "{LP_CONSTRAINT} models a Linear Programming constraint."
	author: "Vivek Shah"
	date: "$Date$"
	revision: "$Revision$"

class
	LP_CONSTRAINT

inherit ANY
	redefine
		out,is_equal
	end

create
	make, make_from

feature
	expression : LP_EXPRESSION
	relational_operator : STRING
	constant : INTEGER

	set_expression(newexpression : like expression)
		-- Set expression in the contraint
		do
			expression := newexpression
		ensure
			expression = newexpression
		end

	set_relational_operator(newop : like relational_operator)
		-- Set relational operator in the constraint
		require
			is_valid_op(newop)
		do
			relational_operator := newop

			-- Remove leading and trailing spaces
			relational_operator.left_adjust
			relational_operator.right_adjust
		ensure
			relational_operator = newop
		end

	set_constant(newconstant : like constant)
		-- Set constant in the constraint
		do
			constant := newconstant
		ensure
			constant = newconstant
		end

	is_valid_op(newop : like relational_operator) : BOOLEAN
		-- Check if the operator is a valid Linear Programming Operator
		do
			Result := False
			if attached newop as attached_newop then
				if attached_newop.is_equal("<") or attached_newop.is_equal(">") or attached_newop.is_equal("<=") or
					attached_newop.is_equal(">=") or attached_newop.is_equal("=") then
					Result := True
				else
					Result := False
				end
			end
		end

	out : STRING
		-- Generate a string representation of the constraint in LP format
		do
			create Result.make_empty
			Result.append(expression.out)
			Result.append (" ")
			Result.append(relational_operator)
			Result.append (" ")
			Result.append(constant.out)
			Result.append (";")
		end

	make
		-- Create clause to make an empty constraint
		do
			create expression.make
			create relational_operator.make_empty
			create constant.default_create
		end

	make_from(new_expression : like expression; new_op : like relational_operator; new_constant : like constant)
		-- Create clause to create a constraint from the constituent componenets
		do
			set_expression (new_expression)
			set_relational_operator (new_op)
			set_constant (new_constant)
		end

	is_equal(other : like Current) : BOOLEAN
		-- Check if two constraints are the same
		do
			Result := Precursor(other)
			if not Result then
				Result := relational_operator.is_equal (other.relational_operator)
				if not Result then
					-- If the relational operators differ check if the two constraints are not negated versions
					-- X - Y < 5 is_equal to Y - X > - 5
					if relational_operator.is_equal ("<") and other.relational_operator.is_equal (">")
						or  relational_operator.is_equal ("<=") and other.relational_operator.is_equal (">=")
						or  relational_operator.is_equal (">") and other.relational_operator.is_equal ("<")
						or  relational_operator.is_equal (">=") and other.relational_operator.is_equal ("<=") then
						Result := constant.is_equal (other.constant.opposite) and then expression.is_equal (other.expression.negated_dup)
					else
						Result := False
					end
				else
					Result := constant.is_equal (other.constant) and then expression.is_equal(other.expression)
				end
			end
		end
end
