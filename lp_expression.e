note
	description: "Summary description for {LP_EXPRESSION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LP_EXPRESSION

inherit ANY
	redefine
		out
	end

create
	make, make_from

feature
	expression : ARRAYED_LIST[LP_LITERAL]

	set_expression(new_expression : like expression)
		do
			expression := new_expression
		end

	get_compacted_expression(literal_list : like expression) : like expression
		-- Generate a compacted list so that no literal with same variable is present more than once
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
					--print("%Nhere 2")
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

				--print("%N Here 3")
				if
					found_flag = True
				then
					-- We found it
					--print("%N Here 4")
					--print(compacted_literal_list.index)
					quantifier := compacted_literal_list.item.quantifier
					--print("%N Here 5")
					compacted_literal_list.item.set_quantifier (quantifier + literal.quantifier)
					--print("%N Here 6")
				else
					create new_literal.make_from(literal)
					compacted_literal_list.extend (new_literal)
				end
				--print("%NHere 7")
				--print(literal_list.index)
			end
		end

	set_compacted_expression(literal_list : like expression)
		do
			expression := get_compacted_expression(literal_list)
		end

	add_literal(new_literal : LP_LITERAL)
		do
			expression.extend (new_literal)
		end

	out : STRING
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
		do
			create expression.make(0)
		end

	make_from(new_expression : like expression)
		do
			set_compacted_expression (new_expression)
		end

	negate
		do
			from
				expression.start
			until
				expression.off
			loop
				expression.item.set_quantifier (expression.item.quantifier.opposite)
				expression.forth
			end
		end
end
