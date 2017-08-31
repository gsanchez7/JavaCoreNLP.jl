#=============================================================================
Minimally wraps the edu.stanford.nlp.pipeline.Annotation.class.

Note, the Java constructor Annotation(text) becomes here
JAnnotation((JString,), text). That's because JAnnotation makes a `JavaCall` call
whose signature requires the extra argument.  See the `JavaCall` documentation.
=============================================================================#
type Annotation
    jann::JAnnotation
end

# TODO: make more meaningful show
Base.show(io::IO, ann::Annotation) = print(io, "Annotation(...)")

function Annotation(text::AbstractString)
    jann = JAnnotation((JString,), text)
    return Annotation(jann)
end



#=============================================================================
Minimally wraps the edu.stanford.nlp.pipeline.StanfordCoreNLP.class.

Note, the Java constructor JStanfordCoreNLP(props) becomes here
JStanfordCoreNLP((JProperties,), jprops). That's because JAnnotation makes a
`JavaCall` call whose signature requires the extra argument.
See the `JavaCall` documentation.
=============================================================================#
# StanfordCoreNLP
type StanfordCoreNLP
    jpipeline::JStanfordCoreNLP
end
#

#To tag a list of sentences and get back a list of tagged sentences:
#List taggedList = tagger.process(List sentences)

#To tag a String of text and to get back a String with tagged words:
#String taggedString = tagger.tagString("Here's a tagged string.")

#To tag a string of correctly tokenized, whitespace-separated words and get a string of tagged words back:
#String taggedString = tagger.tagTokenizedString("Here 's a tagged string .")

Base.show(io::IO, pipeline::StanfordCoreNLP) = print(io, "StanfordCoreNLP(...)")

function StanfordCoreNLP(props::Dict{String, String})
    jprops = to_jprops(props)
    jpipeline = JStanfordCoreNLP((JProperties,), jprops)
    return StanfordCoreNLP(jpipeline)
end


#=============================================================================
Convenience methods that wrap edu.stanford.nlp.pipeline.Annotation methods. See--
https://nlp.stanford.edu/nlp/javadoc/javanlp/edu/stanford/nlp/pipeline/Annotation.html

A generic call is built as follows--
jcall(A, B, C, D, E) where--
   A is a CoreAnnotation (CoreMap) such as an annotated text, sentence, or token.
   B is a method of the class such as 'get' (but many others available).
   C is 'JObject', the return class.
   D is '(JClass,)', the argument class.
   E is  the CoreMap key associated with the desired values in the CoreMap.
For example, in,
   'jcall(sentence, "get", JObject, (JClass,), JTokensAnnotationClass)'
the 'JTokensAnnotationClass' key maps to an array of tokens (the value).
=============================================================================#

#Returns iterable list of annotated sentences in an Annotation.
#N. B., accepts an Annotation object with a CoreAnnotation as its field.
function Sentences(doc::Annotation)
    return narrow(jcall(doc.jann, "get", JObject, (JClass,), JSentencesAnnotationClass))
end


#Returns iterable list of tokens in an annotated sentence.
function Tokens(sentence::JAnnotation)
    return narrow(jcall(sentence, "get", JObject, (JClass,), JTokensAnnotationClass))
end


#Returns the syntactic parse tree of a sentence.
function Tree(sentence::JAnnotation) #Why not JAnnotation?
    return narrow(jcall(sentence, "get", JObject, (JClass,), JTreeAnnotationClass))
end


#Returns the syntactic dependencies of a sentence.
function Semgraph(sentence::JAnnotation)
    return narrow(jcall(sentence, "get", JObject, (JClass,), JCollapsedCCProcessedDependenciesAnnotationClass))
end