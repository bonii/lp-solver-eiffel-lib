note
	description: "{LP_MODEL} models a LP model."
	author: "Vivek Shah"
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
		-- Set the list of variables used in the model
		do
			variable_list := newlist
		ensure
			variable_list = newlist
		end

	set_constraints(newconstraints : like constraints)
		-- Set the list of constraints in the model
		do
			constraints := newconstraints
		ensure
			constraints = newconstraints
		end

	set_objective(newobjective : like objective)
		-- Set the objective in the model
		do
			objective := newobjective
		ensure
			objective = newobjective
		end

	add_constraint(newconstraint : LP_CONSTRAINT)
		-- Add a constraint to the existing constraints
		do
			constraints.extend (newconstraint)
		ensure
			constraints.count = old constraints.count + 1
		end

	make
		-- Create an empty model
		do
			create variable_list.make(0)
			create constraints.make(0)
			create objective.make
		end

	make_from(new_variable_list : like variable_list ; new_constraints : like constraints ; new_objective : like objective)
		-- Create a model from existing components
		do
			set_variable_list(new_variable_list)
			set_constraints(new_constraints)
			set_objective(new_objective)
		end

	debug_out : STRING
		-- Generate string representation of model for debugging
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
		-- Generate string representation of model in LP format
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
		-- Check if two models are the same
		do
			Result := Precursor(other)
			if Result = False then
				Result := objective.is_equal (other.objective) and then is_equal_any_order(constraints,other.constraints)
			end
		end
end
