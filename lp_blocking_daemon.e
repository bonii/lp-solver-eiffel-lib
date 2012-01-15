note
	description: "{LP_SINGLEBLOCKINGDAEMON} models the daemon which runs the LP models and also contains a cache of previous jobs."
	author: "Vivek Shah"
	date: "$Date$"
	revision: "$Revision$"

class
	LP_BLOCKING_DAEMON
inherit
	LP_DAEMON

create
	make

feature
	cache : ARRAYED_LIST[LP_CACHE_ENTRY]
	file_location : STRING
	model_checker : LP_MODEL_CHECKER
	lp_command : STRING

	make(new_file_location : like file_location; new_lp_command : like lp_command ; new_checker : like model_checker)
		-- Create a daemon from the constituent components
		do
			create cache.make(0)
			file_location := new_file_location
			model_checker := new_checker
			lp_command := new_lp_command

			-- Don't remove leading and trailing spaces from the commands or location because on Windows it might land on problems
		end

	run_model(model : LP_MODEL)
		-- Run the model. Also checks if the model exists in the cache
		local
			command,lp_result_string,result_file_name : STRING
			cache_entry : LP_CACHE_ENTRY
			pf : PROCESS_FACTORY
			p : PROCESS
			start_time, end_time : DATE_TIME
			diff : INTERVAL[TIME]
			diff_new : TIME_DURATION
			index : INTEGER
			lp_result : LP_RESULT
		do
			create start_time.make_now
			index := get_index_in_cache (model)
			-- Ideally use is_in_cache but that method does not give index in cache so using the low level method
			-- gives performance benefit especially in big caches with complex model checkers
			if not index.is_less (0) then
				print("%NFound in cache !!! Result follows ")
				lp_result_string := cache.at(index).run_result.result_string_dump
			else
				print("%NNot found in cache !!! Asking LP SOLVE to solve ")
				write_model_file(model)
				create lp_result_string.make_empty
				-- Run the lp process
				create pf
				command := get_command_to_execute
				if attached pf.process_launcher_with_command_line (command, "") as attached_p then
					clear_result_file
					result_file_name := get_file_name(False)
					attached_p.redirect_output_to_file(result_file_name)
					--attached_p.redirect_error_to_file(result_file_name)
					attached_p.launch
					attached_p.wait_for_exit
					lp_result_string.append (read_result_file)
					create lp_result.make
					create cache_entry.make_from(model,False,lp_result)
					cache_entry.set_result_string_dump (lp_result_string)
					cache.extend(cache_entry)
				end
			end
			create end_time.make_now
			print("%N")
			print(lp_result_string)
			print("%NExecuted the solver in seconds : ")
			print(end_time.seconds - start_time.seconds)
			print("%N")
		end

feature{NONE}
	-- Internal methods non exported

	is_in_cache(model : LP_MODEL) : BOOLEAN
		-- Check if a model exists in the cache
		local
			index : INTEGER
		do
			index := get_index_in_cache(model)
			if index.is_less (0) then
				Result := False
			else
				Result := True
			end
		end


	get_index_in_cache(model : LP_MODEL) : INTEGER
		-- Get the index of the model in the cache.
		-- Return -1 if not found in cache
		local
			found_flag : BOOLEAN
		do
			if attached model as attached_model then
				Result := -1
				create found_flag
				from
					cache.start
				until
					cache.off or found_flag = True
				loop
					if attached cache.item as cacheitem then
						if attached cacheitem.model as cachemodel then
							if model_checker.is_same (cachemodel, model) then
								found_flag := True
								Result := cache.index
							end
						end
					end
					cache.forth
				end
			end
		end

	write_model_file(model : LP_MODEL)
		-- Write the model respresentation to be solved in the file
		local
			output_file : PLAIN_TEXT_FILE
			file_name : STRING
		do
			file_name := get_file_name(True)
			create output_file.make_open_write (file_name)
			output_file.put_string (model.out)
			output_file.close
		end

	clear_result_file
		-- Clear the pre existing result file if it exists since process output is appended to file
		-- so existing result file with same name must be cleaned up
		local
			temp_file : PLAIN_TEXT_FILE
			file_name : STRING
		do
			file_name := get_file_name(False)
			create temp_file.make_open_write (file_name)
			temp_file.close
		end

	read_result_file : STRING
		-- Read the result file write by lp solve
		local
			input_file : PLAIN_TEXT_FILE
			file_name : STRING
		do
			create Result.make_empty
			file_name := get_file_name(False)
			create input_file.make_open_read (file_name)
			from
				input_file.start
			until
				input_file.off
			loop
				input_file.read_line
				Result.append (input_file.last_string.twin)
				Result.append ("%N")
			end
			input_file.close
		end

	get_file_name(input_file : BOOLEAN) : STRING
		-- Generate the file names in which the model and the result are to be stored
		do
			create Result.make_empty
			Result.append (file_location)
			Result.append ("lp_model")
			Result.append ((cache.count + 1).out)
			if input_file = True then
				Result.append (".lp")
			else
				Result.append(".res")
			end
		end

	get_command_to_execute : STRING
		-- Generate the command to be executed to run lp solve library
		local
			file_name : STRING
		do
			file_name := get_file_name(True)
			create Result.make_empty
			Result.append (lp_command)
			Result.append (" ")
			Result.append (file_name)
		end
end
