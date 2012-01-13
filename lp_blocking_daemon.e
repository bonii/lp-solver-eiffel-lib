note
	description: "Summary description for {LP_SINGLEBLOCKINGDAEMON}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LP_BLOCKING_DAEMON

create
	make

feature
	cache : ARRAYED_LIST[LP_CACHE_ENTRY]
	file_location : STRING
	command_location : STRING

	make(new_file_location : like file_location; new_command_location : like command_location)
		do
			create cache.make(0)
			file_location := new_file_location
			command_location := new_command_location
		end

	set_cache(newcache : like cache)
		do
			cache := newcache
		ensure
			cache = newcache
		end

	add_to_cache(cacheentry : LP_CACHE_ENTRY)
		do
			cache.extend(cacheentry)
		ensure
			cache.count = old cache.count + 1
		end

	is_in_cache(model : LP_MODEL) : BOOLEAN
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
		local
			found_flag : BOOLEAN
			model_checker : LP_MODEL_LIST_CHECKER
		do
			create model_checker
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
		local
			temp_file : PLAIN_TEXT_FILE
			file_name : STRING
		do
			file_name := get_file_name(False)
			create temp_file.make_open_write (file_name)
			temp_file.close
		end

	read_result_file : STRING
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
		do
			create Result.make_empty
			Result.append ("lp_model")
			Result.append ((cache.count + 1).out)
			if input_file = True then
				Result.append (".lp")
			else
				Result.append(".res")
			end
		end

	get_command_to_execute : STRING
		local
			file_name : STRING
		do
			file_name := get_file_name(True)
			create Result.make_empty
			Result.append (command_location)
			Result.append ("lp_solve ")
			Result.append (file_location)
			Result.append (file_name)
		end


	run_model(model : LP_MODEL)
		local
			command,lp_result,result_file_name : STRING
			cache_entry : LP_CACHE_ENTRY
			pf : PROCESS_FACTORY
			p : PROCESS
			start_time, end_time : DATE_TIME
			diff : INTERVAL[TIME]
			diff_new : TIME_DURATION
		do
			create start_time.make_now
			if is_in_cache(model) then
				print("%NFound in cache%N")
				lp_result := cache.at(get_index_in_cache (model)).run_result
			else
				print("%NWriting model file")
				write_model_file(model)
				print("%NFile Written")
				create lp_result.make_empty
				-- Run the lp process
				create pf
				command := get_command_to_execute
				print(command)
				if attached pf.process_launcher_with_command_line (command, "") as attached_p then
					clear_result_file
					result_file_name := get_file_name(False)
					attached_p.redirect_output_to_file(result_file_name)
					attached_p.redirect_error_to_file(result_file_name)
					attached_p.launch
					attached_p.wait_for_exit
					print("%NReading result file")
					lp_result.append (read_result_file)

				end
				create cache_entry.make_from(model,False,lp_result)
				cache.extend(cache_entry)
			end
			print("%N")
			create end_time.make_now
			print(lp_result)
			print("%NExecuted the solver in seconds : ")
			print(end_time.seconds - start_time.seconds)
			print("%N")
		end
end
