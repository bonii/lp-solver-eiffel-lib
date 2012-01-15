note
	description: "{LP_RESULT} models a LP Result"
	author: "Vivek Shah"
	date: "$Date$"
	revision: "$Revision$"

class
	LP_RESULT

create
	make

feature
	feasible : BOOLEAN
	result_string_dump : STRING

	make
		-- Create an empty result
		do
			create result_string_dump.make_empty
			create feasible.default_create
		end

feature{LP_CACHE_ENTRY}

	set_result_string_dump(string_dump : like result_string_dump)
		-- Set the string dump representation of solution
		-- This should only be visible from the cache
		do
			result_string_dump := string_dump
			-- Parse the string and if the string contains the word Objective: then it is feasible
			if result_string_dump.has_substring ("Value of objective function:") then
				feasible := True
			else
				feasible := False
			end
		ensure
			result_string_dump = string_dump
		end
end
