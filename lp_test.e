note
	description: "Summary description for {LP_TEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LP_TEST

feature
	get_model_1 : LP_MODEL
		local
			literal1, literal2, literal3, literal4, literal5, literal6 : LP_LITERAL
			expression1, expression2, expression3 : LP_EXPRESSION
			constraint1, constraint2 : LP_CONSTRAINT
			objective : LP_OBJECTIVE
			var_list : ARRAYED_LIST[STRING]
			constraints : ARRAYED_LIST[LP_CONSTRAINT]
		do
			create var_list.make (0)
			var_list.extend ("X")
			var_list.extend ("Y")

			create literal1.make
			literal1.set_quantifier (2)
			literal1.set_variable ("X")

			create literal2.make
			literal2.set_quantifier (3)
			literal2.set_variable ("Y")

			create literal3.make
			literal3.set_quantifier (3)
			literal3.set_variable ("X")

			create literal4.make
			literal4.set_quantifier (-2)
			literal4.set_variable ("Y")

			create literal5.make
			literal5.set_quantifier (1)
			literal5.set_variable ("Y")

			create literal6.make
			literal6.set_quantifier (-1)
			literal6.set_variable ("X")

			create expression1.make
			expression1.add_literal (literal1)
			expression1.add_literal (literal2)

			create expression2.make
			expression2.add_literal (literal3)
			expression2.add_literal (literal4)

			create expression3.make
			expression3.add_literal (literal5)
			expression3.add_literal (literal6)

			create constraint1.make_from (expression1, "<", 5)
			create constraint2.make_from (expression2, ">=", 0)

			create constraints.make (0)
			constraints.extend (constraint1)
			constraints.extend (constraint2)

			create objective.make_from (expression3, False)

			create Result.make_from (var_list,constraints,objective)
		end

	get_model_2 : LP_MODEL
		local
			literal1, literal2, literal3, literal4, literal5, literal6 : LP_LITERAL
			expression1, expression2, expression3 : LP_EXPRESSION
			constraint1, constraint2 : LP_CONSTRAINT
			objective : LP_OBJECTIVE
			var_list : ARRAYED_LIST[STRING]
			constraints : ARRAYED_LIST[LP_CONSTRAINT]
		do
			create var_list.make (0)
			var_list.extend ("X")
			var_list.extend ("Y")

			create literal1.make
			literal1.set_quantifier (2)
			literal1.set_variable ("X")

			create literal2.make
			literal2.set_quantifier (3)
			literal2.set_variable ("Y")

			create literal3.make
			literal3.set_quantifier (3)
			literal3.set_variable ("X")

			create literal4.make
			literal4.set_quantifier (-2)
			literal4.set_variable ("Y")

			create literal5.make
			literal5.set_quantifier (1)
			literal5.set_variable ("Y")

			create literal6.make
			literal6.set_quantifier (-1)
			literal6.set_variable ("X")

			create expression1.make
			expression1.add_literal (literal2)
			expression1.add_literal (literal1)


			create expression2.make
			expression2.add_literal (literal4)
			expression2.add_literal (literal3)


			create expression3.make
			expression3.add_literal (literal6)
			expression3.add_literal (literal5)

			create constraint1.make_from (expression1, "<", 5)
			create constraint2.make_from (expression2, ">=", 0)

			create constraints.make (0)
			constraints.extend (constraint2)
			constraints.extend (constraint1)

			create objective.make_from (expression3, False)

			create Result.make_from (var_list,constraints,objective)
		end

	get_model_3 : LP_MODEL
		local
			literal1, literal2, literal3, literal4, literal5, literal6 : LP_LITERAL
			expression1, expression2, expression3 : LP_EXPRESSION
			constraint1, constraint2 : LP_CONSTRAINT
			objective : LP_OBJECTIVE
			var_list : ARRAYED_LIST[STRING]
			constraints : ARRAYED_LIST[LP_CONSTRAINT]
		do
			create var_list.make (0)
			var_list.extend ("X")
			var_list.extend ("Y")

			create literal1.make
			literal1.set_quantifier (2)
			literal1.set_variable ("X")

			create literal2.make
			literal2.set_quantifier (3)
			literal2.set_variable ("Y")

			create literal3.make
			literal3.set_quantifier (3)
			literal3.set_variable ("X")

			create literal4.make
			literal4.set_quantifier (-2)
			literal4.set_variable ("Y")

			create literal5.make
			literal5.set_quantifier (1)
			literal5.set_variable ("X")

			create literal6.make
			literal6.set_quantifier (-1)
			literal6.set_variable ("Y")

			create expression1.make
			expression1.add_literal (literal2)
			expression1.add_literal (literal1)


			create expression2.make
			expression2.add_literal (literal4)
			expression2.add_literal (literal3)


			create expression3.make
			expression3.add_literal (literal6)
			expression3.add_literal (literal5)

			create constraint1.make_from (expression1, "<", 5)
			create constraint2.make_from (expression2, ">=", 0)

			create constraints.make (0)
			constraints.extend (constraint2)
			constraints.extend (constraint1)

			create objective.make_from (expression3, True)

			create Result.make_from (var_list,constraints,objective)
		end


	new_test
		local
			literal1, literal2, literal3, literal4, literal5, literal6 : LP_LITERAL
			expression1, expression2, expression3 : LP_EXPRESSION
			constraint1, constraint2 : LP_CONSTRAINT
			objective : LP_OBJECTIVE
			var_list : ARRAYED_LIST[STRING]
			constraints : ARRAYED_LIST[LP_CONSTRAINT]
		do
			create literal1.make
			literal1.set_quantifier (2)
			literal1.set_variable ("X")

			create literal2.make
			literal2.set_quantifier (3)
			literal2.set_variable ("Y")

			create literal3.make
			literal3.set_quantifier (3)
			literal3.set_variable ("Y")

			create literal4.make
			literal4.set_quantifier (2)
			literal4.set_variable ("X")

			create expression1.make
			expression1.add_literal (literal1)
			expression1.add_literal (literal2)


			create expression2.make
			expression2.add_literal (literal3)
			expression2.add_literal (literal4)


			--print(literal1.is_equal (literal4))
			--print(literal2.is_equal (literal3))
			print(expression1)
			print("%N")
			print(expression2)
			print("%N")
			print(expression1.is_equal (expression2))
		end
end
