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

	make
		do
			create cache.make(0)
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
							if cachemodel.is_same(model) then
								found_flag := True
								Result := cache.index
								cache.forth
							end
						end
					end
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
			command_location : STRING
			file_location : STRING
		do
			file_name := get_file_name(True)
			create Result.make_empty
			file_location := "/universe/studies/eth-zurich/eiffel-lang/solver/"
			command_location := "/usr/bin/"
			Result.append (command_location)
			Result.append ("lp_solve ")
			Result.append (file_location)
			Result.append (file_name)
		end


	run_model(model : LP_MODEL)
		local
			output_file, input_file : PLAIN_TEXT_FILE
			file_name,command,command_location,file_location,lp_result : STRING
			cache_entry : LP_CACHE_ENTRY
			pf : PROCESS_FACTORY
			p : PROCESS
		do
			if is_in_cache(model) then
				print("%NFound in cache%N")
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
					attached_p.redirect_output_to_file(get_file_name(False))
					attached_p.launch
					attached_p.wait_for_exit
					print("%NReading result file")
					lp_result.append (read_result_file)
				end
				print("%N")
				print(lp_result)
				create cache_entry.make_from(model,False,lp_result)
				cache.extend(cache_entry)
			end
		end
end
