#Annotators and their dependencies.
#See https://stanfordnlp.github.io/CoreNLP/dependencies.html
ANNOTATORS = Dict(
    "tokenize" => String[],
    "cleanxml" => ["tokenize"],
    "ssplit" => ["tokenize"],
    "pos" => ["tokenize", "ssplit"],
    "lemma" => ["tokenize", "ssplit", "pos"],
    "ner" => ["tokenize", "ssplit", "pos", "lemma"],
    "regexner" => String[],
    "sentiment" => String[],
    "parse" => ["tokenize", "ssplit"],
    "depparse" => ["tokenize", "ssplit", "pos"],
    "dcoref" => ["tokenize", "ssplit", "pos", "lemma", "ner", "parse"],
    "relation" => ["tokenize", "ssplit", "pos", "lemma", "ner", "depparse"],
    "natlog" => ["tokenize", "ssplit", "pos", "lemma", "depparse"],
    "qquote" => String[]
)

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

type MaxentTagger
    jmet::JMaxentTagger
end

function MaxentTagger(path::String)
    jmet = JMaxentTagger(path)
    return maxEntTagger(jmet)
end

function annotate!(pipeline::StanfordCoreNLP, doc::Annotation)
    jcall(pipeline.jpipeline, "annotate", Void, (JAnnotation,), doc.jann)
end

#Construct a CoreNLP pipeline object suitable for annotate! calls.
function Pipeline(annotators::String...)
    if checkAnnotators(annotators...)
        annList = annotatorList(annotators...)
        return StanfordCoreNLP(Dict("annotations" => annList)) #Other props go here.
    else
        println("Invalid annotator in `pipeline` call.")
        return 1
    end
end

#Check all arguments are valid annotators.
function checkAnnotators(annotators...)
    valid = true
        for a in annotators
            valid = valid && in(a, keys(ANNOTATORS))
        end
    return valid
end

#Construct argument for 'pipeline' call based on annotator dependencies.
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

function Sentences(doc::Annotation) #Why not JAnnotation?
    return narrow(jcall(doc.jann, "get", JObject, (JClass,), JSentencesAnnotationClass))
end

function Tokens(sentence::JAnnotation) #Why not JAnnotation?
    return narrow(jcall(sentence, "get", JObject, (JClass,), JTokensAnnotationClass))
end

function Tagger(met::MaxentTagger, sentence::JAnnotation)
    return narrow(jcall(met, "tagSentence", JObject, (JAnnotation,), sentence))
end

function Tree(sentence::JAnnotation) #Why not JAnnotation?
    return narrow(jcall(sentence, "get", JObject, (JClass,), JTreeAnnotationClass))
end

function Semgraph(sentence::JAnnotation)
    Narrow(semgraph = jcall(sentence, "get", JObject, (JClass,),
                          JCollapsedCCProcessedDependenciesAnnotationClass))
end

function Word(token::JCoreLabel)
    return jcall(token, "get", JString, (JClass,), TextAnnotation)
end

function Lemma(token::JCoreLabel) #Why not JCoreLabel?
    return jcall(token, "lemma", JString, ())
end

#known good
function POS(token::JCoreLabel) #Why not JCoreLabel?
    return jcall(token, "tag", JString, ())
end

#Full call. Should work.
function POS(token::JCoreLabel) #Why not JCoreLabel?
    return jcall(token, "get", JString, (JClass,), JPartOfSpeechAnnotationClass)
end

function NE(token::JCoreLabel)
    return narrow(jcall(token, "get", JObject, (JClass,), JNamedEntityTagAnnotationClass))
end

function tree2string(tree::JTree)
    return jcall(tree, "toString", JString, ())
end
