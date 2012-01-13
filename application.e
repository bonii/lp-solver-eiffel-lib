note
	description : "lp_solver application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			constraint,constraint1 : LP_CONSTRAINT
			file1 : PLAIN_TEXT_FILE
			objective : LP_OBJECTIVE
			model : LP_MODEL
			example,example1,example2,example3 , example4, example5: LP_LITERAL
			literal_list : ARRAYED_LIST[LP_LITERAL]
			literal_list1 : ARRAYED_LIST[LP_LITERAL]
			constraints : ARRAYED_LIST[LP_CONSTRAINT]
			var_list : ARRAYED_LIST[STRING]
			expression , expression1 : LP_EXPRESSION
			daemon : LP_BLOCKING_DAEMON
			--pf : PROCESS_FACTORY
			--p : PROCESS
		do
			--| Add your code here
			create example.make
			example.set_variable ("X")
			example.set_quantifier (2)
			create example2.make
			example2.set_quantifier (3)
			example2.set_variable ("Y")
			create example3.make_from (example2)
			create example1.make_from (example)
			create literal_list.make (0)
			literal_list.extend (example)
			literal_list.extend (example1)
			literal_list.extend (example)
			literal_list.extend (example1)
			literal_list.extend (example2)
			literal_list.extend (example3)

			create example4.make
			create example5.make
			example4.set_quantifier (3)
			example4.set_variable ("X")
			example5.set_quantifier (-2)
			example5.set_variable ("Y")
			create literal_list1.make (0)
			literal_list1.extend (example4)
			literal_list1.extend (example5)
			create expression1.make
			expression1.set_compacted_expression (literal_list1)
			create constraint1.make_from (expression1,">=", 0)
			create var_list.make (0)
			var_list.extend ("X")
			var_list.extend ("Y")
			create expression.make
			create constraint.make
			create file1.make_open_write ("sample1.lp")

			--expression.set_expression (literal_list)
			--print("%N")
			expression.set_compacted_expression (literal_list)
			--expression.add_literal (example)
			constraint.set_expression (expression)
			constraint.set_relational_operator ("<")
			constraint.set_constant (10)
			print(expression)
			print("%N")
			print(constraint)
			create objective.make_from(expression,False)
			print("%N")
			print(objective)
			create constraints.make (0)
			constraints.extend (constraint)
			constraints.extend (constraint1)
			create model.make_from (var_list, constraints, objective)
			file1.put_string (model.out)
			file1.close
			print("%NReal Thing%N")
			print(model)

			create daemon.make
			daemon.run_model(model)
			--expression.add_literal (example1)
			--print(expression)

			--print("Variable is ")
			--print(example.variable)
			--print("%NQuantifier is ")
			--print(example.quantifier)

			--print("%NVariable is ")
			--print(example1.variable)
			--print("%NQuantifier is ")
			--print(example1.quantifier)
			--print ("%NHello Eiffel World!%N")

		end

end
