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
				print("%NWriting to file")
				create file_name.make_empty
				create command.make_empty
				create command_location.make_empty
				create file_location.make_empty
				create lp_result.make_empty
				file_name.append ("lp_model")
				file_name.append ((cache.count + 1).out)
				file_name.append (".lp")
				file_location.append("/universe/studies/eth-zurich/eiffel-lang/solver/")
				command_location.append ("/usr/bin/")
				command_location.append ("lp_solve ")
				command.append (command_location)
				command.append (file_location)
				command.append (file_name)
				print("%N")
				print(command)
				create output_file.make_open_write (file_name)
				output_file.put_string (model.out)
				output_file.close
				print("%NFile Written")
				-- Run the lp process
				create pf
				if attached pf.process_launcher_with_command_line (command, "") as attached_p then
					attached_p.redirect_output_to_file("foo.txt")
					attached_p.launch
					attached_p.wait_for_exit
					create input_file.make_open_read ("foo.txt")
					from
						input_file.start
					until
						input_file.off
					loop
						input_file.read_line
						lp_result.append (input_file.last_string.twin)
						lp_result.append ("%N")
					end
				end
				print("%N")
				print(lp_result)
				create cache_entry.make_from(model,False,0)
				cache.extend(cache_entry)
			end
		end
end
