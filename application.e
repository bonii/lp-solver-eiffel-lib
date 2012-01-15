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
			file_path,command : STRING
			list_model_checker : LP_MODEL_LIST_CHECKER
			simple_model_checker : LP_SIMPLE_MODEL_CHECKER
		do
			create file_path.make_empty
			create command.make_empty
			create simple_model_checker
			create list_model_checker
			print("Enter the absolute location where the lp model files will be written eg. /home/bonii/ (press enter for default project directory) : ")
			io.read_line
			file_path := io.last_string.twin
			print("%NEnter absolute path to the executable to run(eg. /usr/bin/lp_solve) : ")
			io.read_line
			command := io.last_string.twin
			print("Running test cases with simple model checker which recognises 2 models as same if they are same references %N")
			run_tests(file_path,command,simple_model_checker)
			print("Running test cases with intelligent model checker which performs extra tasks of recognising 2 models %N")
			-- Cache is reset when run_tests is called again
			run_tests(file_path,command,list_model_checker)

		end

	run_tests(file_path, command : STRING; model_checker : LP_MODEL_CHECKER)
		-- Run the test cases from the test cases suite
		local
			test : LP_TEST
			model1,model2,model3,model4,model5,model6 : LP_MODEL
			daemon : LP_BLOCKING_DAEMON
		do
			create test
			create daemon.make(file_path,command, model_checker)

			model1 := test.get_model_1
			print("Test Model 1 :")
			print("%N")
			print(model1.out)
			daemon.run_model (model1)

			print("%N Rerunning the previous model again using the same object%N")
			daemon.run_model (model1)

			model2 := test.get_model_2
			print("Test Model 2 :")
			print("%N")
			print(model2.out)
			daemon.run_model (model2)

			model3 := test.get_model_3
			print("Test Model 3 :")
			print("%N")
			print(model3.out)
			daemon.run_model (model3)

			model4 := test.get_model_4
			print("Test Model 4 :")
			print("%N")
			print(model4.out)
			daemon.run_model (model4)

			model5 := test.get_model_5
			print("Test Model 5 :")
			print("%N")
			print(model5.out)
			daemon.run_model (model5)

			model6 := test.get_model_6
			print("Test Model 6 :")
			print("%N")
			print(model6.out)
			daemon.run_model (model6)
		end


end
