JProperties = @jimport java.util.Properties

#Wrapper
type Properties
    jproperties::JProperties
end


#Constructors
##key, value argument
function Properties(key::AbstractString, value::AbstractString)
    jproperties = JProperties(())
    jcall(jproperties, "setProperty", JObject, (JString, JString), key, value)
    return Properties(jproperties)
end

##Dictionary argument
function Properties(d::Dict{String, String})
    jproperties = JProperties(())
    for (k, v) in d
        jcall(jproperties, "setProperty", JObject, (JString, JString), k, v)
    end
    return Properties(jproperties)
end

##Value-only argument. Key defaults to "annotators"
function Properties(value::AbstractString)
    return Properties("annotators", value)
end


#Convenience methods
##Returns a string 'val' corresponding to property 'key'
function get_property(jprops::JProperties, key::AbstractString)
    return jcall(jprops, "getProperty", JString, (JString,), key)
end

##'key' defaults to "annotators"
function get_property(jprops::JProperties)
    return jcall(jprops, "getProperty", JString, (JString,), "annotators")
end



#=
#set_property: Methods for setting properties of a JProperties object.
#All return a JProperties object.

##key, value argument.
function set_property(key::AbstractString, value::AbstractString)
    jprops = JProperties(())
    jcall(jprops, "setProperty", JObject, (JString, JString), key, value)
    return jprops
end

##Dict argument
function set_property(d::Dict{String, String})
    jprops = JProperties(())
    for (k, v) in d
        jcall(jprops, "setProperty", JObject, (JString, JString), k, v)
    end
    return jprops
end

##value-only argument. key defaults to "annotators"
function set_property(value::AbstractString)
    set_property("annotators", value)
end


#Returns the value corresponding to 'key' in the JProperties object argument.
#Returns a string of the 'key' property in jprops::JProperties.
#Usage: value = get_property(jprops, key)
function get_property(jprops::JProperties, key::AbstractString)
    return jcall(jprops, "getProperty", JString, (JString,), key)
end



#Returns a string of the 'annotators' property in jprops::JProperties.
#Usage: annotators = get_annotators(jprops)
function get_annotators(jprops::JProperties)
    return jcall(jprops, "getProperty", JString, (JString,), "annotators")
end

#function set_property(jprops::JProperties, key::AbstractString, value::AbstractString)
#    jcall(jprops, "setProperty", JObject, (JString, JString), key, value)
#end

#=
function to_jprops(d::Dict{String, String})
    jprops = JProperties(())
    for (k, v) in d
        set_property(jprops, k, v)
    end
    return jprops
end
=#
