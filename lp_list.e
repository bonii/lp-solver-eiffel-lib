note
	description: "{LP_LIST} models a LP List class to decorate classes with lists with a special list checker which checks list objects in out of order"
	author: "Vivek Shah"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LP_LIST

feature
	is_equal_any_order(list1 : LIST[ANY] ; list2 : LIST[ANY]) : BOOLEAN
		-- Check if lists are equal where list objects may not specifically be in order
		-- Default list checkers only check in order
		-- Future enhancement can be to see if one list is superset of another
	local
		count : INTEGER
	do
		Result := list1.is_equal (list2)
		if Result = False and list1.count = list2.count then
			--We need to check the inverted case since the lists may contain duplicates
			Result := are_lists_equal(list1,list2) and then are_lists_equal(list2,list1)
		end
	end

feature {NONE}
	are_lists_equal(list1 : LIST[ANY] ; list2 : LIST[ANY]) : BOOLEAN
		-- Check if list elements of first list are present in the other list
		do
			from
				list1.start
				Result := True
			until
				list1.off or not Result
			loop
				from
					list2.start
					Result := False
				until
					list2.off or Result = True
				loop
					if list1.item.is_equal (list2.item) then
						Result := True
					end
					list2.forth
				end
				list1.forth
			end
			list1.start
			list2.start
		ensure
			list1.index = 1
			list2.index = 1
		end
end
