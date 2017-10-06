#=======================================================================
Convenience methods related to construction of pipeline::StanfordCoreNLP.

Usage: pline = pipeline(annotators::String...)

Example: pline = pipeline("pos", "dcoref")

Uses `check_annotators` to validate the annotators in the argument of pipeline,
i.e., it checks that each annotator is a key in ANNOTATORS. ANNOTATORS must be
located in ./data/annotators.jl.

Uses `annotator_list` to build a single, comma-separated string of the
annotators passed to `pipeline` and their dependencies. For example,
annotator_list("pos") returns string "tokenize, ssplit, pos". Annotators
listed in the returned string are unique and ordered: each
annotator is to the right of its dependencies.
=======================================================================#

#Construct a CoreNLP pipeline object suitable for `annotate!` calls.
#=
function pipeline(annotators::String...)
    if check_annotators(annotators...)
        annList = annotator_list(annotators...)
        println("annList = ", annList)  #diagnostic
        return StanfordCoreNLP(Dict("annotations" => annList))
    else
        println("Invalid annotator in `pipeline` call.")
        return 1
    end
end


function pipeline(annotators::String...)
    if check_annotators(annotators...)
        annList = annotator_list(annotators...)
        println("annList = ", annList)  #diagnostic
        jprops = JProperties()
        jcall(jprops, "setProperty", JObject, (JString, JString), "annotators", annList)
        return StanfordCoreNLP(JStanfordCoreNLP((JProperties,), jprops))
    else
        println("Invalid annotator in `pipeline` call.")
        return 1
    end
end


#Returns true if all arguments are valid annotators, false otherwise.
include("./data/annotators.jl")
function check_annotators(annotators...)
    valid = true
        for a in annotators
            valid = valid && in(a, keys(ANNOTATORS))
        end
    return valid
end

#Accepts an unordered list of annotators and returns an ordered, comma-separated
#string of annotators and their dependencies. In the returned string, each
# annotator is to the right of its dependencies. For example,
#annotatorList("pos", "ner") returns "tokenize, ssplit, pos, lemma, ner".
#The return value is intended as the argument of Pipeline(...)
function annotator_list(annotators...)
    ##Push annotators onto a list. Make unique and sort.
    list = String[]
    for a in annotators
        for b in ANNOTATORS[a]
            push!(list, b)
        end
        push!(list, a)
    end
    list = unique(list)


    ##Construct Pipeline() call argument by stringing annotators together.
    arg = ""
    for a in list
       arg = Base.string(arg, a, ",")
    end
#    arg = arg[1:length(arg)-1] #Drop the trailing comma.
    pop!(arg)  #Drop the trailing comma.
end


#Annotates doc.jann according to pipeline. Note, doc is an Annotation
#whereas doc.jann is a JAnnotation.
function annotate!(pipeline::JavaCoreNLP.StanfordCoreNLP, doc::Annotation)   #??
    jcall(pipeline.jpipeline, "annotate", Void, (JAnnotation,), doc.jann)
end
=#
