note
	description: "{LP_TEST} models a test factory which generates various test cases to be run by application"
	author: "Vivek Shah"
	date: "$Date$"
	revision: "$Revision$"

class
	LP_TEST

feature
	get_model_1 : LP_MODEL
		-- Generate an example model with 2 constraints
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
		-- Generate the model as generated in get_model_1 with literals, expressions and constraint list formed in other order
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
		-- Generate the model designed in get_model_1 but with objective expression negated and objective to be minimized
		-- In essence the model remains same where the objective has been negated but the maximisation job has been changed to minimization
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

	get_model_4 : LP_MODEL
		-- Generate a model with expressions containing duplicated variables 1X + 1X instead of 2X
		-- It is the same as the model in get_model_1 (A lot of such test cases can be formed and would be recognised as same in this library)
		local
			literal1, literal2, literal3, literal4, literal5, literal6, literal7, literal8 : LP_LITERAL
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
			literal1.set_quantifier (1)
			literal1.set_variable ("X")

			create literal2.make
			literal2.set_quantifier (1)
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

			create literal7.make
			literal7.set_quantifier (1)
			literal7.set_variable ("X")

			create literal8.make
			literal8.set_quantifier (2)
			literal8.set_variable ("Y")

			--An expression is always stored compacted
			-- So the model will be stores as 2X + 3Y instead of 1X + 1X + 1Y + 2Y
			-- This makes it more performance efficient as compaction is done once
			create expression1.make
			expression1.add_literal (literal2)
			expression1.add_literal (literal1)
			expression1.add_literal (literal7)
			expression1.add_literal (literal8)


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

	get_model_5 : LP_MODEL
		-- Generate a model which is same as in get_model_1 but with constraints reversed
		-- a -  b < 5 is same as b - a  > -5
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
			literal3.set_quantifier (-3)
			literal3.set_variable ("X")

			create literal4.make
			literal4.set_quantifier (2)
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
			create constraint2.make_from (expression2, "<=", 0)

			create constraints.make (0)
			constraints.extend (constraint1)
			constraints.extend (constraint2)

			create objective.make_from (expression3, False)

			create Result.make_from (var_list,constraints,objective)
		end

	get_model_6 : LP_MODEL
		-- Generate an example model which is infeasible
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
			literal1.set_quantifier (1)
			literal1.set_variable ("X")

			create literal2.make
			literal2.set_quantifier (1)
			literal2.set_variable ("Y")

			create literal3.make
			literal3.set_quantifier (1)
			literal3.set_variable ("X")

			create literal4.make
			literal4.set_quantifier (-1)
			literal4.set_variable ("Y")

			create literal5.make
			literal5.set_quantifier (1)
			literal5.set_variable ("X")

			create literal6.make
			literal6.set_quantifier (1)
			literal6.set_variable ("Y")

			create expression1.make
			expression1.add_literal (literal1)
			expression1.add_literal (literal2)

			create expression2.make
			expression2.add_literal (literal3)
			expression2.add_literal (literal4)

			create expression3.make
			expression3.add_literal (literal5)
			expression3.add_literal (literal6)

			create constraint1.make_from (expression1, "<", 1)
			create constraint2.make_from (expression2, ">=", 2)

			create constraints.make (0)
			constraints.extend (constraint1)
			constraints.extend (constraint2)

			create objective.make_from (expression3, False)
			create Result.make_from (var_list,constraints,objective)
		end
end
