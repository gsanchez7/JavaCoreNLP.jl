
#Annotation
type Annotation
    jann::JAnnotation
end

# TODO: make more meaningful show
Base.show(io::IO, ann::Annotation) = print(io, "Annotation(...)")

function Annotation(text::AbstractString)
    jann = JAnnotation((JString,), text)
    return Annotation(jann)
end


# StanfordCoreNLP
type StanfordCoreNLP
    jpipeline::JStanfordCoreNLP
end

Base.show(io::IO, pipeline::StanfordCoreNLP) = print(io, "StanfordCoreNLP(...)")

function StanfordCoreNLP(props::Dict{String, String})
    jprops = to_jprops(props)
    jpipeline = JStanfordCoreNLP((JProperties,), jprops)
    return StanfordCoreNLP(jpipeline)
end


#MaxentTagger
type MaxentTagger
    jmet::JMaxentTagger
end

# Path is the location of parameter files for a trained tagger.
function MaxentTagger(path::String)
    jmet = JMaxentTagger(path)
    return MaxentTagger(jmet)
end


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
include("annotators.jl")
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


#Annotates doc.jann according to pipeline.
function annotate!(pipeline::StanfordCoreNLP, doc::Annotation)
    jcall(pipeline.jpipeline, "annotate", Void, (JAnnotation,), doc.jann)
end
