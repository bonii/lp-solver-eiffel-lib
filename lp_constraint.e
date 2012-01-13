note
	description: "Summary description for {LP_CONSTRAINT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LP_CONSTRAINT

inherit ANY
	redefine
		out
	end

create
	make, make_from

feature
	expression : LP_EXPRESSION
	relational_operator : STRING
	constant : INTEGER

	set_expression(newexpression : like expression)
		do
			expression := newexpression
		ensure
			expression = newexpression
		end

	set_relational_operator(newop : like relational_operator)
		require
			is_valid_op(newop)
		do
			relational_operator := newop
		ensure
			relational_operator = newop
		end

	set_constant(newconstant : like constant)
		do
			constant := newconstant
		ensure
			constant = newconstant
		end

	is_valid_op(newop : like relational_operator) : BOOLEAN
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
		do
			create expression.make
			create relational_operator.make_empty
			create constant.default_create
		end

	make_from(new_expression : like expression; new_op : like relational_operator; new_constant : like constant)
		do
			set_expression (new_expression)
			set_relational_operator (new_op)
			set_constant (new_constant)
		end
end
