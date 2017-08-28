## Annotation
println("pipeline: 2")

type Annotation
    jann::JAnnotation
end

println("pipeline: 8")


# TODO: make more meaningful show
Base.show(io::IO, ann::Annotation) = print(io, "Annotation(...)")

println("pipeline: 14")
function Annotation(text::AbstractString)
    jann = JAnnotation((JString,), text)
    return Annotation(jann)
end



## StanfordCoreNLP
println("pipeline: 23")
type StanfordCoreNLP
    jpipeline::JStanfordCoreNLP
end

Base.show(io::IO, pipeline::StanfordCoreNLP) = print(io, "StanfordCoreNLP(...)")


function StanfordCoreNLP(props::Dict{String, String})
    jprops = to_jprops(props)
    jpipeline = JStanfordCoreNLP((JProperties,), jprops)
    return StanfordCoreNLP(jpipeline)
end


function annotate!(pipeline::StanfordCoreNLP, doc::Annotation)
    jcall(pipeline.jpipeline, "annotate", Void, (JAnnotation,), doc.jann)
end
