#=============================================================================
Minimally wraps the edu.stanford.nlp.tagger.maxent.MaxentTagger.class.

Note, the Java constructor MaxentTagger(path::String) becomes here
MaxentTagger((JString,), path::String). That's because JAnnotation makes a
`JavaCall` call whose signature requires the extra argument.
See the `JavaCall` documentation.
=============================================================================#
type MaxentTagger
    jmet::JMaxentTagger
end

# Path is the location of parameter files for a trained tagger.
function MaxentTagger(path::AbstractString)
    jmet = JMaxentTagger((JString,), path)
    return MaxentTagger(jmet)
end


#=============================================================================
Convenience methods that wrap edu.stanford.nlp.tagger.maxent.MaxentTagger methods. See--
https://nlp.stanford.edu/nlp/javadoc/javanlp/edu/stanford/nlp/tagger/maxent/MaxentTagger.html

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

#To tag a list of sentences and get back a list of tagged sentences:
function MaxentTagger(tagger::MaxentTagger, sentences)
    return narrow(jcall(tagger, "process", JObject, (JArrayList,), sentences)) #JObject -> JArrayList?
end
