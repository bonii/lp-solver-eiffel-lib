note
	description: "{LP_CACHEENTRY} models a single cache entry used by the daemon."
	author: "Vivek Shah"
	date: "$Date$"
	revision: "$Revision$"

class
	LP_CACHE_ENTRY

create
	make, make_from

feature
	model : LP_MODEL
	is_running : BOOLEAN
	run_result : LP_RESULT

	set_model(newmodel : like model)
		-- Set the model in the cache entry
		do
			model := newmodel
		ensure
			model = newmodel
		end

	set_is_running(runval : like is_running)
		-- Set whether the model is currently running. Useful for extension into concurrent lp solve invocations
		do
			is_running := runval
		ensure
			is_running = runval
		end

	set_run_result(runresult : like run_result)
		-- Set the run result in the cache entry
		do
			run_result := runresult
		ensure
			run_result = runresult
		end

	make
		-- Create an empty cache entry
		do
			create model.make
			create is_running.default_create
			create run_result.make
		end

	make_from(new_model : like model ; run_val : like is_running ; new_result : like run_result)
		-- Create a cache entry from the existing components
		do
			set_model(new_model)
			set_is_running(run_val)
			set_run_result(new_result)
		end

feature{LP_DAEMON}
	-- Only daemons should be able to set the internal result representation

	set_result_string_dump(result_string_dump : STRING)
		-- Set the string dump in the result object
		-- Only let the daemon set it
		do
			run_result.set_result_string_dump(result_string_dump)
		end

end
