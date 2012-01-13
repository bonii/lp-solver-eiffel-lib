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
			output_file : PLAIN_TEXT_FILE
			file_name : STRING
			cache_entry : LP_CACHE_ENTRY
		do
			if is_in_cache(model) then
				print("%NFound in cache%N")
			else
				print("%NWriting to file")
				create file_name.make_empty
				file_name.append ("lp_model")
				file_name.append ((cache.count + 1).out)
				file_name.append (".lp")
				create output_file.make_open_write (file_name)
				output_file.put_string (model.out)
				output_file.close
				print("%NFile Written")
				-- Run the lp process
				create cache_entry.make_from(model,False,0)
				cache.extend(cache_entry)
			end
		end
end
