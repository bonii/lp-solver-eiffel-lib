note
	description: "Summary description for {LP_MODEL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LP_MODEL

inherit ANY
	redefine
		out, is_equal
	end
	LP_LIST
	undefine
		out,is_equal
	end

create
	make, make_from

feature
	variable_list : ARRAYED_LIST[STRING]
	constraints : ARRAYED_LIST[LP_CONSTRAINT]
	objective : LP_OBJECTIVE

	set_variable_list(newlist : like variable_list)
		do
			variable_list := newlist
		ensure
			variable_list = newlist
		end

	set_constraints(newconstraints : like constraints)
		do
			constraints := newconstraints
		ensure
			constraints = newconstraints
		end

	set_objective(newobjective : like objective)
		do
			objective := newobjective
		ensure
			objective = newobjective
		end

	add_constraint(newconstraint : LP_CONSTRAINT)
		do
			constraints.extend (newconstraint)
		ensure
			constraints.count = old constraints.count + 1
		end

	make
		do
			create variable_list.make(0)
			create constraints.make(0)
			create objective.make
		end

	make_from(new_variable_list : like variable_list ; new_constraints : like constraints ; new_objective : like objective)
		do
			set_variable_list(new_variable_list)
			set_constraints(new_constraints)
			set_objective(new_objective)
		end

	debug_out : STRING
		do
			create Result.make_empty
			from
				variable_list.start
				Result.append("Variables : ")
			until
				variable_list.off
			loop
				Result.append(variable_list.item)
				if variable_list.index /= variable_list.count then
					Result.append(" , ")
				end
				variable_list.forth
			end
			Result.append ("%N")
			Result.append ("Objective :")
			Result.append (objective.out)
			Result.append ("%NConstraints :%N")
			from
				constraints.start
			until
				constraints.off
			loop
				Result.append(constraints.item.out)
				constraints.forth
				Result.append("%N")
			end
		end

	out : STRING
		do
			create Result.make_empty
			Result.append (objective.out)
			Result.append ("%N")
			from
				constraints.start
			until
				constraints.off
			loop
				Result.append(constraints.item.out)
				constraints.forth
				Result.append("%N")
			end
		end

	is_equal(other : like Current) : BOOLEAN
		do
			Result := objective.is_equal (other.objective) and then is_equal_any_order(constraints,other.constraints)
		end
end
