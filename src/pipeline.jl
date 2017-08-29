#=======================================================================
Convenience methods related to construction of pipeline::StanfordCoreNLP.

Usage: pipeline = Pipeline(annotators::String...)

Example: pipeline = Pipeline("pos", "dcoref")

Uses `checkAnnotators` to validate the annotators in the argument of Pipeline,
i.e., it checks that each annotator is a key in ANNOTATORS.

Uses `annotatorList` to build a single, comma-separated string of the
annotators passed to `Pipeline` and their dependencies. For example,
annotatorList("pos") returns string "pos, ssplit, tokenize". Annotators
listed in the returned string are unique and ordered.
=======================================================================#

#Construct a CoreNLP pipeline object suitable for `annotate!` calls.
function Pipeline(annotators::String...)
    if checkAnnotators(annotators...)
        annList = annotatorList(annotators...)
        return StanfordCoreNLP(Dict("annotations" => annList))
    else
        println("Invalid annotator in `pipeline` call.")
        return 1
    end
end


#Returns true if all arguments are valid annotators, false otherwise.
include("./data/annotators.jl")
function checkAnnotators(annotators...)
    valid = true
        for a in annotators
            valid = valid && in(a, keys(ANNOTATORS))
        end
    return valid
end


#Accepts a list of annotators and returns a comma-separated string of
#annotators and their dependencies. For example,
#annotatorList("pos", "ner") returns "lemma, ner, pos, ssplit, tokenize".
#The return value is intended as the argument of Pipeline(...)
function annotatorList(annotators...)
    ##Push annotators onto a list. Make unique and sort.
    list = String[]
    for a in annotators
        push!(list, a)
        for b in ANNOTATORS[a]
            push!(list, b)
        end
    end
    list = sort(unique(list))

    ##Construct Pipeline() call argument by stringing annotators together.
    arg = ""
    for a in list
       arg = string(arg, a, ", ")
    end
    arg = arg[1:length(arg)-2] #Drop trailing comma and space.
end


#Annotates doc.jann according to pipeline. Note, doc is an Annotation
#whereas doc.jann is a JAnnotation.
function annotate!(pipeline::StanfordCoreNLP, doc::Annotation)
    jcall(pipeline.jpipeline, "annotate", Void, (JAnnotation,), doc.jann)
end
