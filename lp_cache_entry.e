note
	description: "Summary description for {LP_CACHEENTRY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LP_CACHE_ENTRY

create
	make, make_from

feature
	model : LP_MODEL
	is_running : BOOLEAN
	run_result : STRING

	set_model(newmodel : like model)
		do
			model := newmodel
		ensure
			model = newmodel
		end

	set_is_running(runval : like is_running)
		do
			is_running := runval
		ensure
			is_running = runval
		end

	set_run_result(runresult : like run_result)
		do
			run_result := runresult
		ensure
			run_result = runresult
		end

	make
		do
			create model.make
			create is_running.default_create
			create run_result.make_empty
		end

	make_from(new_model : like model ; run_val : like is_running ; new_result : like run_result)
		do
			set_model(new_model)
			set_is_running(run_val)
			set_run_result(new_result)
		end
end
