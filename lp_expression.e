note
	description: "{LP_EXPRESSION} models an expression in a Linear Programming Problem for ex. 2X + 3Y."
	author: "Vivek Shah"
	date: "$Date$"
	revision: "$Revision$"

class
	LP_EXPRESSION

inherit ANY
	redefine
		out, is_equal
	end

	LP_LIST
	undefine
		out, is_equal
	end

create
	make, make_from

feature
	expression : ARRAYED_LIST[LP_LITERAL]

	set_expression(new_expression : like expression)
		-- Setter method only provided for debugging use
		obsolete
			"Use set_compacted_expression, this is buggy"
		do
			expression := new_expression
		end

	get_compacted_expression(literal_list : like expression) : like expression
		-- Generate a compacted list so that no literal with same variable is present more than once, does so by adding the quantifiers
		-- Useful in checking equality of expressions as the expression is stored in the most compact form
		require
			literal_list /= Void
		local
			compacted_literal_list : ARRAYED_LIST[LP_LITERAL]
			new_literal,literal : LP_LITERAL
			quantifier : INTEGER
			found_flag : BOOLEAN
		do
			create compacted_literal_list.make(0)
			Result := compacted_literal_list
			from
				literal_list.start
				create found_flag
			until
				literal_list.off
			loop
				literal := literal_list.item
				literal_list.forth
				--Iterate over the compacted list to check if something exits
				from
					compacted_literal_list.start
					found_flag := False
				until
					compacted_literal_list.off or found_flag = True
				loop
					if attached compacted_literal_list.item as list_literal then
						if list_literal.is_same (literal) = True then
							found_flag := True
						end
					end
					if found_flag = False then
						-- We do not want the item index to change if we found it
						compacted_literal_list.forth
					end

				end
				if
					found_flag = True
				then
					-- We found it
					quantifier := compacted_literal_list.item.quantifier
					compacted_literal_list.item.set_quantifier (quantifier + literal.quantifier)
				else
					create new_literal.make_from(literal)
					compacted_literal_list.extend (new_literal)
				end
			end
		end

	set_compacted_expression(literal_list : like expression)
		-- Setter method to set the compacted expression from the given expression, performance efficient as the expression compaction
		-- is done only once
		do
			expression := get_compacted_expression(literal_list)
		end

	add_literal(new_literal : LP_LITERAL)
		-- Add a literal to the existing expression and compact the next expression
		do
			expression.extend (new_literal)
			set_compacted_expression (expression)
		end

	out : STRING
		-- Generate a string representation of the expression
		do
			from
				create Result.make_empty
				expression.start
			until
				expression.off
			loop
				Result.append_string (expression.item.out)
				if expression.index /= expression.count and expression.i_th (expression.index+1).quantifier >= 0 then
					Result.append("+")
				end
				expression.forth
			end
		end

	make
		-- Create a new empty expression
		do
			create expression.make(0)
		end

	make_from(new_expression : like expression)
		-- Create a new compacted expression from another expression
		do
			set_compacted_expression (new_expression)
		end

	negate
		-- Negate the existing expression i.e. reverse the quantifiers in the literals in the expression
		do
			from
				expression.start
			until
				expression.off
			loop
				expression.item.set_quantifier (expression.item.quantifier.opposite)
				expression.forth
			end
			expression.start
		end

	negated_dup : like Current
		-- Generate a duplicate negated expression of the current expression
		local
			literal : LP_LITERAL
		do
			create Result.make
			from
				expression.start
			until
				expression.off
			loop
				create literal.make
				literal.set_quantifier (expression.item.quantifier.opposite.twin)
				literal.set_variable (expression.item.variable.twin)
				Result.expression.extend (literal)
				expression.forth
			end
			expression.start
		end

	is_equal(other : like Current) : BOOLEAN
		-- Check if two expressions are the same
		do
			Result := Precursor(other)
			if Result = False then
				Result := is_equal_any_order (expression, other.expression)
			end
		end
end
