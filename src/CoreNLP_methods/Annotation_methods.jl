#=============================================================================
edu.stanford.nlp.pipeline.Annotation methods
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
