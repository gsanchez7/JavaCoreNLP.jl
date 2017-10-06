#Shorthand for JavaCall.iterator(iterable_collection).
macro iter(collection)
   return :( JavaCall.iterator($collection) )
end

#Convert to string and then println.
macro print_string(object)
   return :( println(to_string($object)) )
end

#Convert to list and then println.
macro print_list(object)
   return :( println(to_list($object)) )
end

#Convert to Penn and then println.
macro print_penn(object)
   return :( println(pennstring($object)) )
end
