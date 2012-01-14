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
			test : LP_TEST
			model1,model2,model3 : LP_MODEL
			daemon : LP_BLOCKING_DAEMON
		do
			create test
			model1 := test.get_model_1
			create daemon.make("/universe/studies/eth-zurich/eiffel-lang/solver/","/usr/bin/")
			print(model1.out)
			daemon.run_model (model1)

			model2 := test.get_model_2
			print(model2.out)
			daemon.run_model (model2)

			model3 := test.get_model_3
			print(model3.out)
			daemon.run_model (model3)

--			print(model1.constraints.count)
--			print(" ")
--			print(model2.constraints.count)
			--print(model1.constraints.i_th (0).is_equal (model2.constraints.i_th (0)))
			--print(model1.objective.is_equal (model2.objective))
--			test.new_test
		end
end
