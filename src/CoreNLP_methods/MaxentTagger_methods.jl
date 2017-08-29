#=============================================================================
edu.stanford.nlp.tagger.maxent.MaxentTagger methods
https://nlp.stanford.edu/nlp/javadoc/javanlp/edu/stanford/nlp/tagger/maxent/MaxentTagger.html

Must be run as a pre-requisite for edu.stanford.nlp.parser.nndep.DependencyParser

A generic call is built as follows--
jcall(A, B, C, D) where--
   A is a CoreLabel and in practice, a token.
   B is a key associated with the desired value.
   C is 'JString', the return type.
   D is '()'. These calls take no arguments.

For example, in,
   'jcall(token, "lemma", JString, ())'
the 'lemma' key maps to a lemma JString (the value).
=============================================================================#

#

#To tag a list of sentences and get back a list of tagged sentences:
#List taggedList = tagger.process(List sentences)

#To tag a String of text and to get back a String with tagged words:
#String taggedString = tagger.tagString("Here's a tagged string.")

#To tag a string of correctly tokenized, whitespace-separated words and get a string of tagged words back:
#String taggedString = tagger.tagTokenizedString("Here 's a tagged string .")


#??
#Returns a new Sentence that is a copy of the given sentence with all the words tagged with their part-of-speech.
#https://nlp.stanford.edu/nlp/javadoc/javanlp/index.html?edu/stanford/nlp/ling/CoreAnnotations.TokensAnnotation.html
function Tagger(met::MaxentTagger, sentence::JAnnotation)
    return narrow(jcall(met, "tagSentence", JObject, (JAnnotation,), sentence))
end
